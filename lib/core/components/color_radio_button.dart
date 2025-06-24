import 'package:flutter/material.dart';

class ColorRadioButton extends StatefulWidget {
  final EdgeInsetsGeometry? margin;
  final Color color;
  final Function()? onPressed;

  final bool? selected;

  const ColorRadioButton(
      {super.key,
      this.margin,
      required this.color,
      this.selected,
      this.onPressed});

  @override
  State<ColorRadioButton> createState() => _ColorRadioButtonState();
}

class _ColorRadioButtonState extends State<ColorRadioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<double?> _animation;

  static const animationDurationMilliseconds = 185;

  bool isForward = false;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: animationDurationMilliseconds),
        lowerBound: 0.35,
        upperBound: 1,
        value: 1)
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0.75, end: 1).animate(
        CurvedAnimation(parent: _mainController, curve: Curves.easeInOutQuint));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selected == false && _animation.value! >= 0.75) {
      _mainController.forward();
    }

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          isForward = true;
          _mainController.reverse().then((value) {
            isForward = false;
            _mainController.forward();
          });

          if (widget.onPressed != null) widget.onPressed!();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration:
                  Duration(milliseconds: animationDurationMilliseconds * 2),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color
                          .withValues(alpha: widget.selected == true ? .2 : 0),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
            ),
            Container(
              // duration: Duration(milliseconds: animationDurationMilliseconds),
              height: 45 * (_animation.value ?? 1),
              width: 45 * (_animation.value ?? 1),
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      width: 7 * (_mainController.value - 1).abs(),
                      color: Theme.of(context).scaffoldBackgroundColor)),
            ),
          ],
        ),
      ),
    );
  }
}
