import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  final IconData? icon;
  final String? hintText;

  const CustomTextField({super.key, this.controller, this.icon, this.hintText});

  static final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFecf0f6)),
      borderRadius: BorderRadius.circular(12));

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    print("color i'm looking for: ${Theme.of(context).colorScheme.onPrimary}");

    return TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(icon, size: 28, color: Colors.blueGrey.shade800)
              : null,
          enabledBorder: borderStyle,
          focusedBorder: borderStyle.copyWith(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 1.5)),
          hintText: hintText,
          isDense: true,
          hintStyle:
              textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal)),
    );
  }
}
