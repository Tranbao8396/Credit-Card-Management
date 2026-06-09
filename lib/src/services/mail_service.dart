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

  Future<void> sendMail({String? title, String? content}) async {
    final Uri emailLanchUri = Uri(
      scheme: 'mailto',
      path: 'tranbaoworking@gmail.com',
      query: encodeQueryParameters({
        'subject': title ?? '',
        'body': content ?? '',
      }),
    );

    log("Email ne: ${emailLanchUri.toString()}");

    if (await canLaunchUrl(emailLanchUri)) {
      await launchUrl(emailLanchUri);
    } else {
      throw 'Could not launch $emailLanchUri';
    }
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map(
        (MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      )
      .join('&');
}
