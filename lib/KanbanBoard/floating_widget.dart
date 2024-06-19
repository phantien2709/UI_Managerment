import 'package:flutter/material.dart';

class FloatingWidget extends StatelessWidget {
  final Widget child;
  const FloatingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}