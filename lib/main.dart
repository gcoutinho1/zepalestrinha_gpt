import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Ze palestrinha',
      debugShowCheckedModeBanner: false,
      color: Flutter95.background,
      home: const HomeScreen(),
    ),
  );
}
