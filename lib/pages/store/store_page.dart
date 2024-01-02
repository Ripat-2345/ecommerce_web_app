import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
          ),
          children: const [
            Center(
              child: Text("Store"),
            ),
          ],
        ),
      ),
    );
  }
}
