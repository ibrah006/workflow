import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      this.child,
      this.alignment,
      this.color,
      this.hasShadow = true});

  final Widget? child;
  final AlignmentGeometry? alignment;
  final Color? color;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: !hasShadow
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.03),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
