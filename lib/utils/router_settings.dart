import 'package:ecommerce_web_app/pages/auth/change_password_page.dart';
import 'package:ecommerce_web_app/pages/auth/forgot_password_page.dart';
import 'package:ecommerce_web_app/pages/auth/login_page.dart';
import 'package:ecommerce_web_app/pages/auth/register_page.dart';
import 'package:ecommerce_web_app/pages/home/home_page.dart';
import 'package:ecommerce_web_app/pages/not_found_page.dart';
import 'package:ecommerce_web_app/pages/product/product_page.dart';
import 'package:ecommerce_web_app/widgets/custom_sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> _listRoutes = [
  GoRoute(
    path: 'login',
    name: 'login',
    builder: (context, state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: 'register',
    name: 'register',
    builder: (context, state) {
      return const RegisterPage();
    },
  ),
  GoRoute(
    path: 'forgot-password',
    name: 'forgot-password',
    builder: (context, state) {
      return const ForgotPasswordPage();
    },
  ),
  GoRoute(
    path: 'change-password/:token',
    name: 'change-password',
    builder: (context, state) {
      return ChangePasswordPage(
        token: state.pathParameters['token'],
      );
    },
  ),
  GoRoute(
    path: 'home',
    name: 'home',
    builder: (context, state) {
      return const HomePage();
    },
  ),
  GoRoute(
    path: 'product',
    name: 'product',
    builder: (context, state) {
      return const ProductPage();
    },
  ),
  GoRoute(
    path: 'dashboard/:page',
    name: 'dashboard',
    builder: (context, state) {
      return CustomSidebarWidget(
        page: state.pathParameters['page']!,
      );
    },
  ),
];

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: _listRoutes,
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);
