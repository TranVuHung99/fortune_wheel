part of 'wheel.dart';

class _CircleSlice extends StatelessWidget {
  static Path buildSlicePath(double radius, double angle) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(radius, 0)
      ..arcTo(
          Rect.fromCircle(
            center: const Offset(0, 0),
            radius: radius,
          ),
          0,
          angle,
          false)
      ..close();
  }

  final double radius;
  final double angleItem;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;
  final ui.Image? image;

  const _CircleSlice({
    super.key,
    required this.radius,
    required this.fillColor,
    required this.strokeColor,
    required this.angleItem,
    this.strokeWidth = 1,
    this.image,
  })  : assert(radius > 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
        painter: _CircleSlicePainter(
          angle: angleItem,
          fillColor: fillColor,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
          image: image
        ),
      ),
    );
  }
}

class _CircleSliceLayout extends StatelessWidget {
  final Widget? child;
  final _CircleSlice slice;

  const _CircleSliceLayout({
    super.key,
    required this.slice,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: slice.radius,
      height: slice.radius,
      child: ClipPath(
        clipper: _CircleSliceClipper(slice.angleItem),
        child: CustomMultiChildLayout(
          delegate: _CircleSliceLayoutDelegate(slice.angleItem),
          children: [
            LayoutId(
              id: _SliceSlot.slice,
              child: slice,
            ),
            if (child != null)
              LayoutId(
                id: _SliceSlot.child,
                child: Transform.rotate(
                  angle: slice.angleItem / 2,
                  child: child,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
