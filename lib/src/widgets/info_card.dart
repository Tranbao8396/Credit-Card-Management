import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final User? userInfo;
  final Color? cardColor;
  final VoidCallback? onSettingsPressed;

  const InfoCard({super.key, this.userInfo, this.cardColor, this.onSettingsPressed});

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
              color: cardColor??Colors.amber,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Title(
                                color: Colors.black,
                                child: Text(
                                  userInfo?.displayName ?? 'User',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                userInfo?.email ?? 'Email',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Cái này phờ rê nên bạn full quyền',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            onPressed: onSettingsPressed,
                            icon: Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
