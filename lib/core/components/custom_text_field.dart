import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final String? hintText;

  final Function(

      /// [String] value holds the trimmed, updated value of the text field
      String)? onChanged;

  final Function(

      /// [String] value holds the trimmed, updated value of the text field
      String)? onFinished;

  final String? label;

  const CustomTextField(
      {super.key,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.onChanged,
      this.onFinished,
      this.label});

  static final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFecf0f6)),
      borderRadius: BorderRadius.circular(12));

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: textTheme.titleMedium),
          SizedBox(height: 7.0),
        ],
        TextField(
          onTapOutside: (pointerDownEvent) {
            if (onFinished != null) {
              if (controller == null) {
                throw "passing in onFinished callback requires you to pass in a non-null TextEditingController (controller property)";
              }
              onFinished!(controller!.text.trim());
            }

            FocusScope.of(context).unfocus();
          },
          onSubmitted: onFinished,
          controller: controller,
          onChanged:
              onChanged != null ? (value) => onChanged!(value.trim()) : null,
          decoration: InputDecoration(
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, size: 28, color: Colors.blueGrey.shade800)
                  : null,
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, size: 28, color: Colors.blueGrey.shade800)
                  : null,
              enabledBorder: borderStyle,
              focusedBorder: borderStyle.copyWith(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5)),
              hintText: hintText,
              isDense: true,
              hintStyle: textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
}
