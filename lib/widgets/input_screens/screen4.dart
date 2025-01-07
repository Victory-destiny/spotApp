import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';
import 'package:spot/screens/home_screen.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height * 0.73) + 114,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/vector.png', width: 117,),
                  SizedBox(height: 30,),
                  uiHelper.robotoText(t1: '정보가 입력 되었습니다!', w: FontWeight.w700, size: 26,
                      s: FontStyle.normal, c: Color(0xFF333333)),
                  uiHelper.robotoText(t1: '이제 시작 해볼까요?', w: FontWeight.w700, size: 26,
                      s: FontStyle.normal, c: Color(0xFF333333)),
                ],
              ),
            ),

            Container(
              width: uiHelper.mediaW(context: context, size: 0.9),
              height: 60,
              child: ElevatedButton(onPressed: () {
                print('next');
                mainProvider.moveStful(context: context, route: HomeScreen());
              },

                child: Center(
                  child: uiHelper.robotoText(t1: '시작하기', w: FontWeight.w700,
                    size: 20, s: FontStyle.normal, c: Colors.white,),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA500),
                  padding: EdgeInsets.all(0),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200)
                  ),
                ).copyWith(
                  overlayColor: WidgetStatePropertyAll(Colors.transparent), // 눌림 효과 제거
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
