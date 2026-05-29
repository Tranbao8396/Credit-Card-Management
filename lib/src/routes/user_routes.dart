import 'package:credit_management/src/pages/cardPage/card_page.dart';

class UserRoutes {
  static const String home = '/';

  static Map<String, dynamic> getRoutes() {
    return {
      home: {'widget': const HomePage()},
    };
  }
}
