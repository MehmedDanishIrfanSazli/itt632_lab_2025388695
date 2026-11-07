import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const UserDirectoryApp());

class UserDirectoryApp extends StatelessWidget {
  const UserDirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2256A8)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, centerTitle: false),
      ),
      home: const HomeScreen(),
    );
  }
}
