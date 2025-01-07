import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';
import 'package:spot/screens/home_screen.dart';
import 'dart:convert'; // JSON 변환을 위해 필요
import 'package:http/http.dart' as http;

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  String name = '';
  String age = '';
  String phoneNumber = '';
  String role = '';

  void initcont() async {
    final loadname = await mainProvider.loadStrongData('name');
    final loadage = await mainProvider.loadStrongData('age');
    final loadphoneNumber= await mainProvider.loadStrongData('phoneNumber');
    final loadrole= await mainProvider.loadStrongData('role');

    name = loadname ?? '';
    age = loadage ?? '';
    phoneNumber = loadphoneNumber ?? '';
    role = loadrole ?? '';
  }

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
              child: ElevatedButton(onPressed: () async {
                final url = Uri.parse("https://your-server-url.com/login"); // 서버 URL
                final payload = {
                  "role": role, //부모, 자녀
                  "name": name, // 유저네임
                  "age": age,  // 비밀번호
                  "phoneNumber": phoneNumber , // 비밀번호
                };

                try {
                  final response = await http.post(
                    url,
                    headers: {
                      "Content-Type": "application/json", // JSON 형식 명시
                    },
                    body: jsonEncode(payload), // JSON 형태로 변환
                  );

                  if (response.statusCode >= 200 && response.statusCode < 300) {
                    // 요청 성공 (로그인 성공)
                    print("Login Successful: ${response.body}");
                    mainProvider.moveStful(context: context, route: HomeScreen());
                  } else {
                    // 요청 실패 (에러 처리)
                    print("Login Failed: ${response.statusCode} - ${response.body}");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("로그인에 실패했습니다. 다시 시도해주세요!"))
                    );
                  }
                } catch (e) {
                  // 네트워크 에러 또는 기타 예외 처리
                  print("Error: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("서버와 연결할 수 없습니다."))
                  );
                }

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
