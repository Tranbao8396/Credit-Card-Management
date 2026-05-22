import 'package:flutter/material.dart';

class LinedTitle extends StatelessWidget {
  final String title;

  const LinedTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 2,
            color: const Color.fromARGB(221, 112, 0, 62),
          ),
        ),
      ],
    );
  }
}