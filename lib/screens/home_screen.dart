import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';
import 'package:spot/screens/chat_screen.dart';
import 'package:spot/screens/day_check_screen.dart';
import 'package:spot/screens/timer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  bool isLoaded = false; // 데이터가 로드되었는지 추적하는 변수

  void updataScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    mainProvider.initSharedPreferences();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainProvider.addListener(updataScreen);
    });
    initcont(); // 비동기적으로 데이터 로딩
  }

  @override
  void dispose() {
    super.dispose();
    mainProvider.removeListener(updataScreen);
  }

  void initcont() async {
    final loadname = await mainProvider.loadStrongData('name');

    setState(() {
      name = loadname ?? '';
      isLoaded = true; // 데이터가 로드되었으므로 화면 렌더링을 허용
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: mainProvider.pageController,
        physics: const NeverScrollableScrollPhysics(), //스크롤 금지
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: uiHelper.mediaW(context: context, size: 0.05)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60 + MediaQuery.of(context).padding.top,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      uiHelper.robotoText(t1: 'SPOT', w: FontWeight.w900,
                          size: 30, s: FontStyle.italic, c: Color(0xFFFFA500))
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        uiHelper.robotoText(t1: name, w: FontWeight.w700,
                            size: 25, s: FontStyle.normal, c: Color(0xFFFFA500)),
                        uiHelper.robotoText(t1: ' 학생은', w: FontWeight.w700,
                            size: 25, s: FontStyle.normal, c: Colors.black),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        uiHelper.robotoText(t1: '출석 ', w: FontWeight.w700,
                            size: 25, s: FontStyle.normal, c: Colors.black),
                        uiHelper.robotoText(t1: '2', w: FontWeight.w700,
                            size: 25, s: FontStyle.normal, c: Color(0xFFFFA500)),
                        uiHelper.robotoText(t1: '일째 입니다', w: FontWeight.w700,
                            size: 25, s: FontStyle.normal, c: Colors.black),
                      ],
                    ),
                  ],
                ),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: uiHelper.mediaW(context: context, size: 0.9),
                      height: uiHelper.mediaH(context: context, size: 0.15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _checkBox(t1: '월요일', check: true),
                          _checkBox(t1: '화요일', check: false),
                          _checkBox(t1: '수요일', check: true),
                          _checkBox(t1: '목요일', check: true),
                          _checkBox(t1: '금요일', check: false),
                          _checkBox(t1: '토요일', check: false),
                          _checkBox(t1: '일요일', check: true),
                        ],
                      ),
                    ),

                    Container(
                      width: uiHelper.mediaW(context: context, size: 0.9),
                      height: uiHelper.mediaH(context: context, size: 0.28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _dayBox(t1: '월요일', time1: '0', time2: '0'),
                          _dayBox(t1: '화요일', time1: '0', time2: '0'),
                          _dayBox(t1: '수요일', time1: '0', time2: '0'),
                          _dayBox(t1: '목요일', time1: '0', time2: '0'),
                          _dayBox(t1: '금요일', time1: '0', time2: '0'),
                          _dayBox(t1: '토요일', time1: '0', time2: '0'),
                          _dayBox(t1: '일요일', time1: '0', time2: '0'),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      width: uiHelper.mediaW(context: context, size: 0.9),
                      height: uiHelper.mediaH(context: context, size: 0.18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          uiHelper.robotoText(t1: '인기 있는 목표 상품', w: FontWeight.w700, size: 16, s: FontStyle.normal, c: Colors.black),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/p1.png', height: uiHelper.mediaH(context: context, size: 0.09),),
                                  uiHelper.robotoText(t1: '보조 배터리', w: FontWeight.w700, size: 10, s: FontStyle.normal, c: Colors.black)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/p2.png', height: uiHelper.mediaH(context: context, size: 0.09),),
                                  uiHelper.robotoText(t1: '스마트폰', w: FontWeight.w700, size: 10, s: FontStyle.normal, c: Colors.black)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/images/p3.png', height: uiHelper.mediaH(context: context, size: 0.09),),
                                  uiHelper.robotoText(t1: '카메라', w: FontWeight.w700, size: 10, s: FontStyle.normal, c: Colors.black)
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ),
                  ],
                ),),
              ],
            ),
          ),
          TimerScreen(),
          ChatScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(

        onTap: mainProvider.changeTabIndex,
        currentIndex: mainProvider.currentTabIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈',),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: '타이머',),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '채팅',),
        ],
      ),
    );
  }

  Container _checkBox({required String t1, required bool check}) =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: check ? t1 == '일요일' ? Color(0xFFFFA500) : Colors.white : Color(0xFFE1E0E0),
                image: check ? DecorationImage(image: AssetImage('assets/images/vector.png'), fit: BoxFit.contain) :
                null,
              ),
              child: t1 == '일요일' ? Icon(Icons.card_giftcard_outlined, color: Colors.white, size: 21,) : null,
            ),
            SizedBox(height: 9,),
            uiHelper.robotoText(t1: t1, w: FontWeight.w700, size: 10, s: FontStyle.normal, c: Color(0xFF333333)),
          ],
        ),
      );

  Container _dayBox({required String t1, required String time1, required String time2}) =>
      Container(
        width: uiHelper.mediaW(context: context, size: 0.9),
        height: uiHelper.mediaH(context: context, size: 0.28) / 7 -2,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15,),
            Container(
              width: (uiHelper.mediaW(context: context, size: 0.9)) - 15,
              decoration: BoxDecoration(
                  border: t1 != '일요일' ? Border(
                      bottom: BorderSide(
                        color: Color(0xFFCACACA),
                        width: 0.5,
                      )
                  ) : null
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      uiHelper.robotoText(t1: t1, w: FontWeight.w700, size: 16, s: FontStyle.normal, c: Color(0xFF333333)),
                      SizedBox(width: uiHelper.mediaW(context: context, size: 0.15),),
                      uiHelper.robotoText(t1: time1, w: FontWeight.w700, size: 16, s: FontStyle.normal, c: Color(0xFFFFA500)),
                      uiHelper.robotoText(t1: ' 시간 ', w: FontWeight.w700, size: 16, s: FontStyle.normal, c: Color(0xFF333333)),
                      uiHelper.robotoText(t1: time2, w: FontWeight.w700, size: 16, s: FontStyle.normal, c: Color(0xFFFFA500)),
                      uiHelper.robotoText(t1: ' 분 ', w: FontWeight.w700, size: 16, s: FontStyle.normal, c: Color(0xFF333333)),
                    ],
                  ),
                  IconButton(onPressed: () => mainProvider.moveStful(context: context, route: DayCheckScreen()),
                      icon: Icon(Icons.arrow_forward_ios, size: 18,)),
                ],
              ),
            )
          ],
        )
      );
}
