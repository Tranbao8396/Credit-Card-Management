import 'package:credit_management/src/layout/guest_layout.dart';
import 'package:credit_management/src/layout/home_layout.dart';
import 'package:credit_management/src/routes/guest_routes.dart';
import 'package:credit_management/src/routes/user_routes.dart';
import 'package:credit_management/src/services/authentication_service.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static bool get isLoggedIn => AuthenticationService.instance.isAuthenticated;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final guestRoutes = GuestRoutes.getRoutes();
    final userRoutes = UserRoutes.getRoutes();

    if (guestRoutes.containsKey(settings.name)) {
      if (isLoggedIn) {
        final userRoute = userRoutes['/'];
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              HomeLayout(child: userRoute['widget']),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      } else {
        final guestRoute = guestRoutes[settings.name];
        return MaterialPageRoute(
          builder: (context) => GuestLayout(child: guestRoute['widget']),
        );
      }
    }

    // Check if the route exists in user routes
    if (userRoutes.containsKey(settings.name)) {
      if (!isLoggedIn) {
        final guestRoute = guestRoutes['/login'];
        return MaterialPageRoute(
          builder: (context) => GuestLayout(child: guestRoute['widget']),
        );
      } else {
        final userRoute = userRoutes[settings.name];
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              HomeLayout(child: userRoute['widget']),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      }
    }

    // If the route is not found, show an error page
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
