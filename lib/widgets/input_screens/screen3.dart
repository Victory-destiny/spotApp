import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  late TextEditingController productNameController;
  late TextEditingController productLinkController;
  String productName = '';
  String productLink = '';
  bool isLoaded = false; // 데이터가 로드되었는지 추적하는 변수

  @override
  void initState() {
    super.initState();
    mainProvider.initSharedPreferences();
    initcont(); // 비동기적으로 데이터 로딩
  }

  @override
  void dispose() {
    productNameController.dispose();
    productLinkController.dispose();
    super.dispose();
  }

  void initcont() async {
    final loadproductName = await mainProvider.loadStrongData('productName');
    final loadproductLink = await mainProvider.loadStrongData('productLink');

    setState(() {
      productName = loadproductName ?? '';
      productLink = loadproductLink ?? '';

      // 데이터 로드 후에 TextEditingController 초기화
      productNameController = TextEditingController(text: productName);
      productLinkController = TextEditingController(text: productLink);

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
            _inputBox(w: uiHelper.mediaW(context: context, size: 0.9), t1: '상품명',
                cont: productNameController, t2: '목표 상품을 입력해 주세요', cont1: 'productName'),
            SizedBox(height: 25,),
            _inputBox(w: uiHelper.mediaW(context: context, size: 0.9), t1: '상품 링크',
                cont: productLinkController, t2: '목표 상품의 링크를 입력해 주세요', cont1: 'productLink'),
          ],
        ),
      ),
    );
  }

  Container _inputBox({required double w, required String t1,
    required TextEditingController cont, required String t2, required String cont1}) =>
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
                        textAlign: TextAlign.left,
                        controller: cont,
                        cursorColor: Color(0xFFA7A6A6),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFA7A6A6),
                        ),
                        decoration: InputDecoration(
                          hintText: t2,
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA7A6A6),
                          ),
                          contentPadding: EdgeInsets.only(bottom: 5, left: 8),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          mainProvider.saveStringData(cont1, cont.text);
                          mainProvider.see(t1: cont1);
                        },
                      ),),
                    ],
                  ),


                ))
              ],
            )
          ],
        ),
      );
}
