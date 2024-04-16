import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "List",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
