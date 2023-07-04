import 'package:flutter/material.dart';

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double borderThickness;
  final Color borderColor;

  const CustomSliderThumbShape({
    required this.thumbRadius,
    required this.borderThickness,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double>? activationAnimation,
    required Animation<double>? enableAnimation,
    required bool isDiscrete,
    required TextPainter? labelPainter,
    required RenderBox parentBox,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
  }) {
    final Canvas canvas = context.canvas;
    final outerRadius = thumbRadius;
    final innerRadius = thumbRadius - borderThickness;
    final centerOffset = Offset(center.dx, center.dy);

    // Paint the border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness;
    canvas.drawCircle(centerOffset, outerRadius, borderPaint);

    // Paint the thumb
    final thumbPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;
    canvas.drawCircle(centerOffset, innerRadius, thumbPaint);
  }
}
