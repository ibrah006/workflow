import 'package:flutter/material.dart';

class OutlinedIconButton extends StatefulWidget {
  final EdgeInsetsGeometry? margin;
  final IconData icon;
  final Function()? onPressed;
  final bool? selected;
  final Color? iconColor;

  const OutlinedIconButton(
      {super.key,
      this.margin,
      required this.icon,
      this.onPressed,
      this.selected,
      this.iconColor});

  @override
  State<OutlinedIconButton> createState() => _OutlinedIconButtonState();
}

class _OutlinedIconButtonState extends State<OutlinedIconButton>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<Color?> _colorAnimation;

  late AnimationController _iconScaleController;
  late Animation<double> _iconScaleAnimation;

  static const animationDurationMilliseconds = 150;
  static const iconScaleAnimationDurationMilliseconds = 400;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDurationMilliseconds),
    )..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(
      begin: Color(0xFFecf0f6),
      end: Color(0xFF3b72e3),
    ).animate(_mainController);

    _iconScaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: iconScaleAnimationDurationMilliseconds),
    )..addListener(() {
        setState(() {});
      });

    _iconScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _iconScaleController,
        curve: Curves.easeInExpo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected == false && _mainController.value == 1) {
      _mainController.reverse();
    }

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: IconButton.outlined(
          onPressed: () async {
            // Animation
            if (widget.selected != null && !_mainController.isAnimating) {
              if (_mainController.value == 0) {
                _mainController.forward();
                _iconScaleController.forward().then((value) {
                  _iconScaleController.reverse();
                });
              }
            }

            await Future.delayed(Duration(
                milliseconds: (animationDurationMilliseconds / 2).toInt()));

            // On press callback
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          },
          style: OutlinedButton.styleFrom(
              minimumSize: Size(50, 50),
              side: BorderSide(
                  color: widget.selected != null
                      ? _colorAnimation.value!
                      : Color(0xFFecf0f6),
                  width: 2 + (_mainController.value * 1.5)),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(13.0 + (2 * _mainController.value)),
              ),
              iconSize: 30,
              iconColor: widget.iconColor),
          icon: Transform.scale(
              scale: 1 + (_iconScaleAnimation.value * .25),
              child: Icon(widget.icon))),
    );
  }
}
