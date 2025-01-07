import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      mainProvider.moveStless(context: context, route: LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 90),
            Text('SPOT', style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Roboto',
              fontSize: 80,
              fontStyle: FontStyle.italic,
              color: Color(0xFFFFA500),
            ),),
          ],
        ),
      ),
    );
  }
}
