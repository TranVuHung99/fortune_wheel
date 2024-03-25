part of 'wheel.dart';

enum HapticImpact { none, light, medium, heavy }

Offset _calculateWheelOffset(BoxConstraints constraints, TextDirection textDirection) {
  final smallerSide = getSmallerSide(constraints);
  var offsetX = constraints.maxWidth / 2;
  if (textDirection == TextDirection.rtl) {
    offsetX = offsetX * -1 + smallerSide / 2;
  }
  return Offset(offsetX, constraints.maxHeight / 2);
}

double _calculateAlignmentOffset(Alignment alignment) {
  if (alignment == Alignment.topRight) {
    return _math.pi * 0.25;
  }

  if (alignment == Alignment.centerRight) {
    return _math.pi * 0.5;
  }

  if (alignment == Alignment.bottomRight) {
    return _math.pi * 0.75;
  }

  if (alignment == Alignment.bottomCenter) {
    return _math.pi;
  }

  if (alignment == Alignment.bottomLeft) {
    return _math.pi * 1.25;
  }

  if (alignment == Alignment.centerLeft) {
    return _math.pi * 1.5;
  }

  if (alignment == Alignment.topLeft) {
    return _math.pi * 1.75;
  }

  return 0;
}

class _WheelData {
  final BoxConstraints constraints;
  final int itemCount;
  final int itemRatio;
  final TextDirection textDirection;

  late final double smallerSide = getSmallerSide(constraints);
  late final double largerSide = getLargerSide(constraints);
  late final double sideDifference = largerSide - smallerSide;
  late final Offset offset = _calculateWheelOffset(constraints, textDirection);
  late final Offset dOffset = Offset(
    (constraints.maxHeight - smallerSide) / 2,
    (constraints.maxWidth - smallerSide) / 2,
  );
  late final double diameter = smallerSide;
  late final double radius = diameter / 2;

  _WheelData({
    required this.constraints,
    required this.itemCount,
    required this.itemRatio,
    required this.textDirection,
  });
}

class FortuneWheel extends HookWidget implements Widget {
  /// The default value for [indicators] on a [FortuneWheel].
  /// Currently uses a single [TriangleIndicator] on [Alignment.topCenter].

  static const StyleStrategy kDefaultStyleStrategy = AlternatingStyleStrategy();

  /// {@macro flutter_fortune_wheel.FortuneWidget.items}
  final List<FortuneItem> items;

  /// {@macro flutter_fortune_wheel.FortuneWidget.selected}
  final Stream<int> selected;

  /// {@macro flutter_fortune_wheel.FortuneWidget.rotationCount}
  final int rotationCount;

  /// {@macro flutter_fortune_wheel.FortuneWidget.duration}
  final Duration duration;

  /// {@macro flutter_fortune_wheel.FortuneWidget.indicators}
  final List<FortuneIndicator> indicators;

  /// {@macro flutter_fortune_wheel.FortuneWidget.animationType}
  final Curve curve;

  /// {@macro flutter_fortune_wheel.FortuneWidget.onAnimationStart}
  final VoidCallback? onAnimationStart;

  /// {@macro flutter_fortune_wheel.FortuneWidget.onAnimationEnd}
  final VoidCallback? onAnimationEnd;

  /// {@macro flutter_fortune_wheel.FortuneWidget.animateFirst}
  final bool animateFirst;

  /// {@macro flutter_fortune_wheel.FortuneWidget.onFling}
  final VoidCallback? onFling;

  /// The position to which the wheel aligns the selected value.
  ///
  /// Defaults to [Alignment.topCenter]
  final Alignment alignment;

  /// Called with the index of the item at the focused [alignment] whenever
  /// a section border is crossed.
  final ValueChanged<int>? onFocusItemChanged;

  final StyleStrategy styleStrategy;

  double _getAngle(double progress) {
    return 2 * _math.pi * rotationCount * progress;
  }

  /// {@template flutter_fortune_wheel.FortuneWheel}
  /// Creates a new [FortuneWheel] with the given [items], which is centered
  /// on the [selected] value.
  ///
  /// {@macro flutter_fortune_wheel.FortuneWidget.ctorArgs}.
  ///
  /// See also:
  ///  * [FortuneBar], which provides an alternative visualization.
  /// {@endtemplate}
  static const Duration kDefaultDuration = Duration(seconds: 5);

  static const List<FortuneIndicator> kDefaultIndicators = <FortuneIndicator>[
    FortuneIndicator(
      alignment: Alignment.topCenter,
      child: RectangleIndicator(),
    ),
  ];

  const FortuneWheel({
    super.key,
    required this.items,
    this.rotationCount = 5,
    this.selected = const Stream<int>.empty(),
    this.duration = kDefaultDuration,
    this.curve = FortuneCurve.spin,
    this.indicators = kDefaultIndicators,
    this.animateFirst = true,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.alignment = Alignment.topCenter,
    this.onFling,
    this.styleStrategy = kDefaultStyleStrategy,
    this.onFocusItemChanged,
  })  : assert(items.length > 1);

  double _calculateSliceAngle(int index, int itemCount, int ratio, int selectedIndex) {
    final anglePerChild = 2 * _math.pi / itemCount;
    final childAngle = anglePerChild * getItemPositionRatio(index);
    final firstSliceAngle = anglePerChild * items[selectedIndex].ratio;
    final angleOffset = -(_math.pi / 2 + firstSliceAngle / 2);
    return childAngle + angleOffset;
  }

  int getTotalItemRatio() {
    int count = 0;
    for (var item in items) {
      count += item.ratio;
    }
    return count;
  }

  int getItemPositionRatio(int id) {
    int count = 0;
    for (int i = 0; i < id; i++) {
      count += items[i].ratio;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final rotateAnimCtrl = useAnimationController(duration: duration);
    final rotateAnim = CurvedAnimation(parent: rotateAnimCtrl, curve: curve);
    Future<void> animate() async {
      if (rotateAnimCtrl.isAnimating) {
        return;
      }

      await Future.microtask(() => onAnimationStart?.call());
      await rotateAnimCtrl.forward(from: 0);
      await Future.microtask(() => onAnimationEnd?.call());
    }

    useEffect(() {
      if (animateFirst) animate();
      return null;
    }, []);

    final selectedIndex = useState<int>(0);

    useEffect(() {
      final subscription = selected.listen((event) {
        selectedIndex.value = event;
        animate();
      });
      return subscription.cancel;
    }, []);

    return Stack(
      children: [
        AnimatedBuilder(
          animation: rotateAnim,
          builder: (context, _) {
            return LayoutBuilder(builder: (context, constraints) {
              final wheelData = _WheelData(
                constraints: constraints,
                itemCount: items.length,
                textDirection: Directionality.of(context),
                itemRatio: getTotalItemRatio(),
              );
              final indexSelected = selectedIndex.value;
              final selectedAngle = -2 * _math.pi * getItemPositionRatio(indexSelected) / getTotalItemRatio();
              final rotationAngle = _getAngle(rotateAnim.value);
              final alignmentOffset = _calculateAlignmentOffset(alignment);
              final totalAngle = selectedAngle + rotationAngle;
              final transformedItems = [
                for (var i = 0; i < items.length; i++)
                  TransformedFortuneItem(
                    item: items[i],
                    angle: totalAngle +
                        alignmentOffset +
                        _calculateSliceAngle(
                          i,
                          getTotalItemRatio(),
                          items[i].ratio,
                          indexSelected,
                        ),
                    offset: Offset((constraints.maxWidth / 2), constraints.maxHeight / 2),

                  ),
              ];

              return SizedBox.expand(
                child: _CircleSlices(
                  styleStrategy: styleStrategy,
                  items: transformedItems,
                  wheelData: wheelData,
                ),
              );
            });
          },
        ),
        for (var it in indicators)
          IgnorePointer(
            child: _WheelIndicator(indicator: it),
          ),
      ],
    );
  }
}
