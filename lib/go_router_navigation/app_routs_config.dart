import 'package:api_call_sqlight_flu_bloc/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/login_screen.dart';
import '../view/register_screen.dart';

class MyAppNavigation {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: 'Login',
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'Register',
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: 'Home',
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
