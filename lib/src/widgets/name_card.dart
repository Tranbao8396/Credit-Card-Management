import 'package:flutter/material.dart';

class NameCard extends StatelessWidget {
  final Widget? child;
  final Color? cardColor;
  final VoidCallback? onSettingsPressed;

  const NameCard({
    super.key,
    this.child,
    this.cardColor,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Container(
            decoration: BoxDecoration(
              // Phải khớp bo góc với Card bên trong
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              color: cardColor ?? Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
                side: BorderSide(width: 4),
              ),
              clipBehavior: Clip
                  .antiAlias, // Giúp hình ảnh bên trong cũng được bo góc theo Card
              child: Column(
                children: [
                  // Nội dung văn bản
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: double.infinity,
                          ),
                          child: child
                        ),
                        if (onSettingsPressed != null)
                          Positioned(
                            top: -10,
                            right: -10,
                            child: IconButton(
                              onPressed: onSettingsPressed,
                              icon: Icon(Icons.edit),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
