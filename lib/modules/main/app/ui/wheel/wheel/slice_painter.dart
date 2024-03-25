part of 'wheel.dart';

/// Draws a slice of a circle. The slice's arc starts at the right (3 o'clock)
/// and moves clockwise as far as specified by angle.
class _CircleSlicePainter extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;
  final double strokeWidth;
  final double angle;
  final ui.Image? image;

  const _CircleSlicePainter({
    required this.fillColor,
    this.strokeColor,
    this.strokeWidth = 1,
    this.angle = _math.pi / 2,
    this.image,
  }) : assert(angle > 0 && angle < 2 * _math.pi);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = _math.min(size.width, size.height);
    final path = _CircleSlice.buildSlicePath(radius, angle);

    // fill slice area
    canvas.drawPath(
      path,
      Paint()
        ..color = image != null ? Colors.transparent : fillColor
        ..style = PaintingStyle.fill,
    );

    // draw slice border
    if (strokeWidth > 0) {
      canvas.drawPath(
        path,
        Paint()
          ..color = strokeColor!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );

      canvas.drawPath(
        Path()
          ..arcTo(
              Rect.fromCircle(
                center: const Offset(0, 0),
                radius: radius,
              ),
              0,
              angle,
              false),
        Paint()
          ..color = strokeColor!
          ..strokeWidth = strokeWidth * 2
          ..style = PaintingStyle.stroke,
      );

      if (image != null) {
        canvas.rotate(angle / 2);
        paintImage(
            canvas: canvas,
            fit: BoxFit.cover,
            rect:Rect.fromCircle(
              center: const Offset(0, 0),
              radius: radius,
            ),
            image: image!);
      }
    }
  }

  @override
  bool shouldRepaint(_CircleSlicePainter oldDelegate) {
    return angle != oldDelegate.angle ||
        fillColor != oldDelegate.fillColor ||
        strokeColor != oldDelegate.strokeColor ||
        strokeWidth != oldDelegate.strokeWidth ||
        image != oldDelegate.image;
  }
}
