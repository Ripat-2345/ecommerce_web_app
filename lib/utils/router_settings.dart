// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_web_app/pages/auth/change_password_page.dart';
import 'package:ecommerce_web_app/pages/auth/forgot_password_page.dart';
import 'package:ecommerce_web_app/pages/auth/login_page.dart';
import 'package:ecommerce_web_app/pages/auth/register_page.dart';
import 'package:ecommerce_web_app/pages/home/home_page.dart';
import 'package:ecommerce_web_app/pages/not_found_page.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/widgets/custom_sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) {
        return LoginPage();
      },
      redirect: (context, state) async {
        final data = await readFromStorage('authData');
        if (data != null) {
          return "/";
        }
        return '/login';
      },
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) {
        return const RegisterPage();
      },
      redirect: (context, state) async {
        final data = await readFromStorage('authData');
        if (data != null) {
          return "/";
        }
        return '/register';
      },
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) {
        return const ForgotPasswordPage();
      },
      redirect: (context, state) async {
        final data = await readFromStorage('authData');
        if (data != null) {
          return "/";
        }
        return '/forgot-password';
      },
    ),
    GoRoute(
      path: '/change-password/:token',
      name: 'change-password',
      builder: (context, state) {
        return ChangePasswordPage(
          token: state.pathParameters['token'],
        );
      },
      redirect: (context, state) async {
        final data = await readFromStorage('authData');
        if (data != null) {
          return "/";
        }
        return '/change-password';
      },
    ),
    GoRoute(
      path: '/dashboard/:page',
      name: 'dashboard',
      builder: (context, state) {
        return CustomSidebarWidget(
          page: state.pathParameters['page']!,
        );
      },
      redirect: (context, state) async {
        final data = await readFromStorage('authData');
        final page = state.pathParameters['page']!;
        if (data == null) {
          return "/";
        }
        return '/dashboard/$page';
      },
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);
