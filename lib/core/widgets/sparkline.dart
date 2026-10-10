import 'package:flutter/material.dart';

/// A small trend line with a soft fill beneath it. Draws nothing for fewer
/// than two points.
class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.values,
    required this.color,
    this.height = 44,
  });

  final List<num> values;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(painter: _SparklinePainter(values, color)),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter(this.values, this.color);

  final List<num> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final low = values.reduce((a, b) => a < b ? a : b).toDouble();
    final high = values.reduce((a, b) => a > b ? a : b).toDouble();
    final span = high == low ? 1.0 : high - low;
    // Keep the stroke inside the box.
    const inset = 2.0;
    Offset at(int i) => Offset(
      i / (values.length - 1) * size.width,
      inset + (1 - (values[i] - low) / span) * (size.height - inset * 2),
    );

    final line = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < values.length; i++) {
      line.lineTo(at(i).dx, at(i).dy);
    }
    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas
      ..drawPath(fill, Paint()..color = color.withValues(alpha: 0.14))
      ..drawPath(
        line,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round,
      )
      ..drawCircle(at(values.length - 1), 3.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.values != values || old.color != color;
}
