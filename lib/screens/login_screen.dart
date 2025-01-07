import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';
import 'package:spot/screens/start_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: uiHelper.mediaW(context: context, size: 0.07),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: uiHelper.mediaW(context: context, size: 0.86),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: uiHelper.mediaH(context: context, size: 0.17)),
                  uiHelper.robotoText(t1: 'SPOT', w: FontWeight.w900, size: 60, s: FontStyle.italic, c: Color(0xFFFFA500)),
                  uiHelper.robotoText(t1: '처음이신가요?', w: FontWeight.w900, size: 24, s: FontStyle.normal, c: Color(0xFFFFA500)),
                  uiHelper.robotoText(t1: '지금 바로 시작해보세요!', w: FontWeight.w900, size: 24, s: FontStyle.normal, c: Color(0xFFFFA500)),
                ],
              ),
            ),
            Column(
              children: [
                _buttonBox(context: context, c1: Color(0xFFFFA500), c2: Colors.white,
                    t1: '학생입니다', fun: () {
                      mainProvider.saveStringData('role', 'students');
                    }),
                SizedBox(height: 16,),
                _buttonBox(context: context, c1: Colors.white, c2: Color(0xFFFFA500),
                    t1: '부모입니다', fun: () {
                  mainProvider.saveStringData('role', 'parents');
                }),
                SizedBox(height: uiHelper.mediaH(context: context, size: 0.1),)
              ],
            ), //Role
          ],
        ),
      )
    );
  }



  Container _buttonBox({required BuildContext context, required Color c1, required Color c2,
    required String t1, required VoidCallback fun}) =>
      Container(
        width: uiHelper.mediaW(context: context, size: 0.86),
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            fun();
            print(t1);
            mainProvider.see(t1: "role");
            mainProvider.moveStless(context: context, route: StartScreen());
          },
          child: uiHelper.robotoText(t1: t1, w: FontWeight.w700, size: 18, s: FontStyle.normal, c: c2),

          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.all(0),
            elevation: 0,
            backgroundColor: c1,
            side: BorderSide(color: Color(0xFFFFA500), width: 3),
            shadowColor: Colors.transparent,
          ).copyWith(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      );
}
