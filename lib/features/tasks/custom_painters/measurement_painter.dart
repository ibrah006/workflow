import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:workflow/features/tasks/data/edge.dart';
import 'package:workflow/features/tasks/data/marked_point.dart';

class MeasurementPainter extends CustomPainter {
  final List<MarkedPoint> points;
  final List<Edge> edges;

  MeasurementPainter(this.points, this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (final edge in edges) {
      _drawDottedLine(canvas, edge.start.position, edge.end.position, dotPaint);

      // Draw length label if available
      if (edge.length != null) {
        final midX = (edge.start.position.dx + edge.end.position.dx) / 2;
        final midY = (edge.start.position.dy + edge.end.position.dy) / 2;

        final textSpan = TextSpan(
          text: "${edge.length!.toStringAsFixed(1)} cm",
          style: TextStyle(color: Colors.black, fontSize: 12),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(midX - textPainter.width / 2, midY - textPainter.height / 2),
        );
      }
    }

    // Draw the points
    final pointPaint = Paint()..color = Color(0xFF3b72e3);
    for (final point in points) {
      canvas.drawCircle(point.position, 10, pointPaint);
    }
  }

  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dotLength = 4.0;
    const double gap = 4.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = (Offset(dx, dy)).distance;
    final direction = Offset(dx / distance, dy / distance);

    double current = 0.0;
    while (current < distance) {
      final from = start + direction * current;
      final to = start + direction * (current + dotLength).clamp(0, distance);
      canvas.drawLine(from, to, paint);
      current += dotLength + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
