import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  final String? token;
  const ChangePassword({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(token!),
      ),
    );
  }
}
