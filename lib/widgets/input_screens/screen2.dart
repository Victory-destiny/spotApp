import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late TextEditingController timeController;
  String time = '';
  bool isLoaded = false; // 데이터가 로드되었는지 추적하는 변수

  @override
  void initState() {
    super.initState();
    mainProvider.initSharedPreferences();
    initcont(); // 비동기적으로 데이터 로딩
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  void initcont() async {
    final loadtime = await mainProvider.loadStrongData('time');

    setState(() {
      time = loadtime ?? '';

      // 데이터 로드 후에 TextEditingController 초기화
      timeController = TextEditingController(text: time);

      isLoaded = true; // 데이터가 로드되었으므로 화면 렌더링을 허용
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          width: uiHelper.mediaW(context: context, size: 0.84),
          height: uiHelper.mediaH(context: context, size: 0.265),
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(15)
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/target_icon.png', width: 31,),
                  SizedBox(width: 3,),
                  uiHelper.robotoText(t1: '목표시간', w: FontWeight.w700, size: 20,
                      s: FontStyle.normal, c: Color(0xFF333333)),
                ],
              ),

              Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.84 - 28,
                      // height: 70,
                      // color: Colors.red,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextField(
                              cursorColor: Color(0xFFB7B6B6),
                              controller: timeController,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 60,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFB7B6B6),
                              ),
                              decoration: InputDecoration(
                                hintText: '0', // Placeholder
                                hintStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 60,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFB7B6B6),
                                ),
                                border: InputBorder.none,
                                isDense: true, // Reduce padding
                                contentPadding: EdgeInsets.only(right: 8, bottom: 7),
                              ),
                              onChanged: (text) {
                                mainProvider.saveStringData('time', timeController.text);
                                mainProvider.see(t1: 'time');
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          uiHelper.robotoText(t1: '시간', w: FontWeight.w700,
                              size: 26, s: FontStyle.normal, c: Color(0xFFB7B6B6)),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.84 - 28,
                      height: MediaQuery.of(context).size.height * 0.054,
                      child: ElevatedButton(onPressed: () async {
                        mainProvider.saveStringData('time', timeController.text);
                        mainProvider.see(t1: 'time');
                      },

                        child: Center(
                          child: uiHelper.robotoText(t1: '설정하기', w: FontWeight.w700,
                              size: 16, s: FontStyle.normal, c: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFA500),
                          padding: EdgeInsets.all(0),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21)
                          ),
                        ).copyWith(
                          overlayColor: WidgetStatePropertyAll(Colors.transparent), // 눌림 효과 제거
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
