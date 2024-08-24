import 'package:flutter/material.dart';


class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        body: Center(
          child: Container(
            height: 50,
            width: 50,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
