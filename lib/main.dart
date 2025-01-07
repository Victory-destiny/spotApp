import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/screens/home_screen.dart';
import 'package:spot/screens/login_screen.dart';
import 'package:spot/screens/splash_screen.dart';
import 'package:spot/screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  mainProvider.initSharedPreferences();
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.light(primary: Colors.white, secondary: Colors.black),
    ),
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

