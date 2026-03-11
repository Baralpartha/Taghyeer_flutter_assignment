// app_empty_view.dart
import 'package:flutter/material.dart';

class AppEmptyView extends StatelessWidget {
  final String message;
  const AppEmptyView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}