import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';

class CustomInputScreen extends StatelessWidget {
  final int number;
  final String t1;
  final String t2;
  final StatefulWidget main;
  final VoidCallback fun;
  const CustomInputScreen({super.key, required this.number,
    required this.t1, required this.t2, required this.main, required this.fun});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: uiHelper.mediaH(context: context, size: 0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: uiHelper.mediaW(context: context, size: 0.02),),
                          IconButton(onPressed: fun,
                            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,),),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: uiHelper.mediaW(context: context, size: 0.05)),
                        child: Column(
                          children: [
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                _ball(num: 1, t1: '1'),
                                SizedBox(width: 10,),
                                _ball(num: 2, t1: '2'),
                                SizedBox(width: 10,),
                                _ball(num: 3, t1: '3')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: uiHelper.mediaW(context: context, size: 0.05)),
                  height: 114,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      uiHelper.robotoText(t1: t1, w: FontWeight.w700, size: 26,
                          s: FontStyle.normal, c: Color(0xFF333333)),
                      uiHelper.robotoText(t1: t2, w: FontWeight.w700, size: 26,
                          s: FontStyle.normal, c: Color(0xFF333333)),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              width: uiHelper.mediaW(context: context, size: 0.9),
              height: MediaQuery.of(context).size.height * 0.53,
              child: main,
            ),

            Container(
              width: uiHelper.mediaW(context: context, size: 0.9),
              height: 60,
              child: ElevatedButton(onPressed: () {
                print('next');
                mainProvider.addStart();
              },

                child: Center(
                  child: uiHelper.robotoText(t1: '다음', w: FontWeight.w700,
                    size: 20, s: FontStyle.normal, c: Colors.white,),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF666666),
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
            // SizedBox(height: MediaQuery.of(context).size.height * 0.07,)
          ],
        ),
      ),
    );
  }

  Container _ball({required int num, required String t1}) =>
      Container(
        alignment: Alignment.center,
        width: 32,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: num == number ? Color(0xFFFFA500) : Color(0xFFE1E0E0)
        ),
        child: Text(t1, style: TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: num == number ? Colors.white : Color(0xFF666666)
        ),),
      );
}
