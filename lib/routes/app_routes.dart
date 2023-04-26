import 'package:auth_firebase/screens/screens.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/pdf_screen.dart';

class AppRouter {
  static const initialRoute = '/login';
  static final menuOptions = <MenuOption>[
    MenuOption(
        route: '/login',
        name: 'Login',
        screen: const LoginScreen(),
        icon: Icons.card_membership),
    MenuOption(
        route: '/register',
        name: 'Register',
        screen: const RegisterScreen(),
        icon: Icons.app_registration_rounded),
    MenuOption(
        route: '/home',
        name: 'Home',
        screen: const HomeScreen(),
        icon: Icons.card_membership),
    MenuOption(
        route: '/about',
        name: 'Home',
        screen: const AboutScreen(),
        icon: Icons.card_membership),
    MenuOption(
        route: '/contact',
        name: 'Home',
        screen: const ContactScreen(),
        icon: Icons.card_membership),
    MenuOption(
        route: '/signature',
        name: 'signature',
        screen: const SignaturePdf(),
        icon: Icons.picture_as_pdf_outlined),
    MenuOption(
        route: '/pdf',
        name: 'pdf',
        screen: const PdfScreen(),
        icon: Icons.picture_as_pdf_outlined),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'/login': (BuildContext context) => const LoginScreen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }
}
