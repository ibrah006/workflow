import 'package:flutter/material.dart';

class DraggablePoint {
  Offset position;
  String? label; // Optional: if you want to name points (like A, B, C)
  Color color;

  DraggablePoint({
    required this.position,
    this.label,
    this.color = Colors.blue,
  });

  // Clone method (optional, but useful)
  DraggablePoint copyWith({
    Offset? position,
    String? label,
    Color? color,
  }) {
    return DraggablePoint(
      position: position ?? this.position,
      label: label ?? this.label,
      color: color ?? this.color,
    );
  }
}
