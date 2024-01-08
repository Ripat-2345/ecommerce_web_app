import 'package:ecommerce_web_app/providers/auth_provider.dart';
import 'package:ecommerce_web_app/providers/product_provider.dart';
import 'package:ecommerce_web_app/providers/user_provider.dart';
import 'package:ecommerce_web_app/utils/router_settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(create: (_) => AuthProvider()),
        Provider<UserProvider>(create: (_) => UserProvider()),
        Provider<ProductProvider>(create: (_) => ProductProvider()),
      ],
      child: MaterialApp.router(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        routerConfig: router,
      ),
    );
  }
}
