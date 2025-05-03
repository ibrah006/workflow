import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {super.key,
      this.child,
      this.alignment,
      this.color,
      this.hasShadow = true,
      this.margin,
      this.onPressed});

  final Widget? child;
  final AlignmentGeometry? alignment;
  final Color? color;
  final bool hasShadow;
  final EdgeInsetsGeometry? margin;
  final Function? onPressed;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isPressedDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed != null ? widget.onPressed!() : null;
      },
      // onTapDown: (details) {
      //   setState(() {
      //     isPressedDown = true;
      //   });
      //   widget.onPressed != null ? widget.onPressed!() : null;
      // },
      // onTapUp: (details) {
      //   setState(() {
      //     isPressedDown = false;
      //   });
      // },
      // onTapCancel: () {
      //   setState(() {
      //     isPressedDown = false;
      //   });
      // },
      // onPanEnd: (details) {
      //   setState(() {
      //     isPressedDown = false;
      //   });
      // },
      onLongPress: () {
        // TODO: Haptic feedback
      },
      onLongPressEnd: (details) {
        setState(() {
          isPressedDown = false;
        });
      },
      child: AnimatedScale(
        scale: isPressedDown ? .95 : 1,
        duration: Duration(milliseconds: 25),
        child: Container(
          margin: widget.margin,
          alignment: widget.alignment,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: !widget.hasShadow
                ? null
                : [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.04),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
            color: widget.color ?? Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
