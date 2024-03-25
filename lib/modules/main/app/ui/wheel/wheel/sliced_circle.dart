part of 'wheel.dart';

class _TransformedCircleSlice extends StatelessWidget {
  final TransformedFortuneItem item;
  final _WheelData wheelData;
  final StyleStrategy styleStrategy;
  final int index;

  const _TransformedCircleSlice({
    super.key,
    required this.item,
    required this.index,
    required this.wheelData,
    required this.styleStrategy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = item.style ??
        styleStrategy.getItemStyle(theme, index, wheelData.itemCount);

    return _CircleSliceLayout(
      slice: _CircleSlice(
        radius: wheelData.radius,
        angleItem: (_math.pi * 2 / wheelData.itemRatio) * item.ratio ,
        fillColor:  style.color,
        strokeColor: Colors.white,
        strokeWidth: 1,
        image: item.style?.image,
      ),
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: UITextStyle.white_14,
        child: item.child,
      ),
    );
  }
}

class _CircleSlices extends StatelessWidget {
  final List<TransformedFortuneItem> items;
  final _WheelData wheelData;
  final StyleStrategy styleStrategy;

  const _CircleSlices({
    super.key,
    required this.items,
    required this.wheelData,
    required this.styleStrategy,
  });

  @override
  Widget build(BuildContext context) {
    final slices = [
      for (var i = 0; i < items.length; i++)
        Transform.translate(
          offset: items[i].offset,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: items[i].angle,
            child: _TransformedCircleSlice(
              styleStrategy: styleStrategy,
              item: items[i],
              index: i,
              wheelData: wheelData,
            ),
          ),
        ),
    ];

    return Stack(
      children: slices,
    );
  }
}
