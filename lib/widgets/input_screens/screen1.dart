import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/ui_helper.dart';

import 'package:spot/presentation/providers/main_provider.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  String name = '';
  String age = '';
  bool isLoaded = false; // 데이터가 로드되었는지 추적하는 변수

  @override
  void initState() {
    super.initState();
    mainProvider.initSharedPreferences();
    initcont(); // 비동기적으로 데이터 로딩
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void initcont() async {
    final loadname = await mainProvider.loadStrongData('name');
    final loadage = await mainProvider.loadStrongData('age');

    setState(() {
      name = loadname ?? '';
      age = loadage ?? '';

      // 데이터 로드 후에 TextEditingController 초기화
      nameController = TextEditingController(text: name);
      ageController = TextEditingController(text: age);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inputBox(w: uiHelper.mediaW(context: context, size: 0.68), t1: '이름',
                align: TextAlign.center, cont: nameController, type: TextInputType.text,
                t2: '사용하실 이름을 입력해 주세요', ts: 14, cont1: 'name'),
            SizedBox(height: 25,),
            _inputBox(w: uiHelper.mediaW(context: context, size: 0.36), t1: '나이',
                align: TextAlign.right, cont: ageController, type: TextInputType.number,
                t2: '0', ts: 20, cont1: 'age'),
          ],
        ),
      ),
    );
  }

  Container _inputBox({required double w, required String t1, required TextAlign align,
  required TextEditingController cont, required TextInputType type, required String t2,
  required double ts, required String cont1}) =>
      Container(
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            uiHelper.robotoText(t1: t1, w: FontWeight.w700, size: 14,
                s: FontStyle.normal, c: Color(0xFF333333)),
            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 20,),
                Expanded(child: Container(
                  height: 43,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    children: [
                      Flexible(child: TextField(
                        textAlign: align,
                        controller: cont,
                        cursorColor: Color(0xFFA7A6A6),
                        keyboardType: type,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: ts,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFA7A6A6),
                        ),
                        decoration: InputDecoration(
                          hintText: t2,
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: ts,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA7A6A6),
                          ),
                          contentPadding: EdgeInsets.only(bottom: 9, right: 8),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          mainProvider.saveStringData(cont1, cont.text);
                          mainProvider.see(t1: cont1);
                        },
                      ),),
                      t1 == '나이' ?
                      Row(
                        children: [
                          uiHelper.robotoText(t1: '세', w: FontWeight.w700, size: 14,
                              s: FontStyle.normal, c: Color(0xFFA7A6A6)),
                          SizedBox(width: 10,),
                        ],
                      ) : Text(''),
                    ],
                  ),


                ))
              ],
            )
          ],
        ),
      );
}
