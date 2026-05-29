import 'package:credit_management/src/widgets/card_button.dart';
import 'package:flutter/material.dart';

class ConfirmDialogWidget {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog<bool>(
      context: context,
      builder: (context) =>
          ConfirmDialog(title: title, message: message, onConfirm: onConfirm),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 255, 10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 3,
          ),
        ),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CardButton(
                        onPressed: () => Navigator.of(context).pop(),
                        text: 'Thôi khỏi',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CardButton(onPressed: onConfirm, text: 'Triển đê'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
