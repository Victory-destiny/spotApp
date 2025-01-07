import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/screens/login_screen.dart';
import 'package:spot/widgets/custom_input_screen.dart';
import 'package:spot/widgets/input_screens/screen1.dart';
import 'package:spot/widgets/input_screens/screen2.dart';
import 'package:spot/widgets/input_screens/screen3.dart';
import 'package:spot/widgets/input_screens/screen4.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: mainProvider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CustomInputScreen(number: 1, t1: '학생의 정보를', t2: '입력 해주세요!', main: Screen1(),
            fun: () => mainProvider.moveStless(context: context, route: LoginScreen()),),
          CustomInputScreen(number: 2, t1: '목표 시간을', t2: '입력 해주세요!', main: Screen2(),
              fun: mainProvider.deleteStart),
          CustomInputScreen(number: 3, t1: '목표 상품을', t2: '입력 해주세요!', main: Screen3(),
            fun: mainProvider.deleteStart),
          Screen4(),
        ],
      ),
    );
  }
}
