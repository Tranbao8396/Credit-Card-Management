import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;

  const CardButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? const Color.fromARGB(255, 29, 122, 45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              buttonColor ?? const Color.fromARGB(255, 29, 122, 45),
            ),
            foregroundColor: WidgetStateProperty.all(textColor ?? Colors.white),
            // padding: WidgetStateProperty.all(
            //   const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            // ),
            textStyle: WidgetStateProperty.all(
              TextStyle(fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(width: 4),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
