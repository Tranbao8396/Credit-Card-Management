import 'package:flutter/material.dart';

class NotifyDialogWidget {
  static void show(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => NotifyDialog(title: title, message: message),
    );
  }
}

class NotifyDialog extends StatelessWidget {
  final String title;
  final String message;

  const NotifyDialog({super.key, required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      content: Text(message),
    );
  }
}
