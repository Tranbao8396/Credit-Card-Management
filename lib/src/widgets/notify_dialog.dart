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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text(title, style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
