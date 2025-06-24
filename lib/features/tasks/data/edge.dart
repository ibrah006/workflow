import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/providers/state_update_provider.dart';
import 'package:workflow/features/tasks/data/marked_point.dart';

class Edge {
  final MarkedPoint start;
  final MarkedPoint end;
  double? length; // can be null until user inputs
  String? labelText;
  Edge(this.start, this.end, {this.length, this.labelText});

  Widget label() {
    final start = this.start.position;
    final end = this.end.position;
    final mid = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);

    return Positioned(
      left: mid.dx - 25,
      top: mid.dy - 12,
      child: Container(
        width: 50,
        height: 24,
        child: TextField(
          controller: TextEditingController(text: length?.toStringAsFixed(1)),
          keyboardType: TextInputType.number,
          onTap: () {},
          onSubmitted: (value) {},
          onTapOutside: (event) {},
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          ),
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
