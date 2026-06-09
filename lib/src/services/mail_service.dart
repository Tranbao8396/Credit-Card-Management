import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MailService extends ChangeNotifier {
  String? title;
  String? content;

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  void setContent(String value) {
    content = value;
    notifyListeners();
  }

  Future<void> sendMail(String title, String content) async {
    final Uri emailLanchUri = Uri(
      scheme: 'mailto',
      path: 'tranbaoworking@gmail.com',
      queryParameters: {'subject': Uri.encodeComponent(title), 'body': Uri.encodeComponent(content)},
    );

    log("Email ne: ${emailLanchUri.toString()}");

    if (await canLaunchUrl(emailLanchUri)) {
      await launchUrl(emailLanchUri);
    } else {
      throw 'Could not launch $emailLanchUri';
    }
  }
}
