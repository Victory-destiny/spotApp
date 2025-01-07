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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed, // 네비게이션 바의 타입
        selectedItemColor: Color(0xFFFFA500), // 선택된 아이템 색상
        unselectedItemColor: Color(0xFF666666), // 선택되지 않은 아이템 색상
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Color(0xFFF4F4F4), // 네비게이션 바 배경 색상
      ),
    ),
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

