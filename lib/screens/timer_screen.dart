import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late DateTime today;
  late String weekday;
  late List<String> subjects = []; // 과목 리스트

  @override
  void initState() {
    super.initState();
    mainProvider.initSharedPreferences();
    today = DateTime.now();
    int weekdayNumber = today.weekday;
    List<String> weekDays = ["월", "화", "수", "목", "금", "토", "일"];
    weekday = weekDays[weekdayNumber - 1];

    _loadSubjects(); // 저장된 과목 가져오기
  }

  void _loadSubjects() async {
    final loadsubjects = await mainProvider.loadStringListData('subjects');
    setState(() {
      subjects = loadsubjects ?? ['국어'];
    });
  }

  void _addSubject() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('새 과목 추가'),
          content: TextField(
            cursorColor: Colors.grey,
            controller: controller,
            decoration: InputDecoration(
              hintText: '새 과목 이름',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // 기본 상태에서의 선 색상
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // 포커스 상태에서의 선 색상
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: uiHelper.robotoText(
                  t1: '취소',
                  w: FontWeight.w700,
                  size: 12,
                  s: FontStyle.normal,
                  c: Colors.black),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (controller.text.trim().isNotEmpty) {
                    subjects.add(controller.text.trim());
                  }
                });
                mainProvider.saveStringListData('subjects', subjects);
                Navigator.of(context).pop();
              },
              child: uiHelper.robotoText(
                  t1: '저장',
                  w: FontWeight.w700,
                  size: 12,
                  s: FontStyle.normal,
                  c: Colors.black),
            ),
          ],
        );
      },
    );
  }

  void _editSubject(int index) async {
    TextEditingController controller = TextEditingController(text: subjects[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('과목 수정'),
          content: TextField(
            cursorColor: Colors.grey,
            controller: controller,
            decoration: InputDecoration(
              hintText: '새 과목 이름',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // 기본 상태에서의 선 색상
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // 포커스 상태에서의 선 색상
              ),
            ),
            style: TextStyle(fontSize: 16, color: Colors.black), // 텍스트 스타일
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: uiHelper.robotoText(t1: '취소', w: FontWeight.w700, size: 12, s: FontStyle.normal, c: Colors.black),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  subjects[index] = controller.text; // 과목 이름 수정
                });
                mainProvider.saveStringListData('subjects', subjects);
                Navigator.of(context).pop();
              },
              child: uiHelper.robotoText(t1: '저장', w: FontWeight.w700, size: 12, s: FontStyle.normal, c: Colors.black),
            ),
          ],
        );
      },
    );
  }

  void _deleteSubject(int index) {
    setState(() {
      subjects.removeAt(index); // 과목 삭제
    });
    mainProvider.saveStringListData('subjects', subjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: uiHelper.mediaH(context: context, size: 0.06)),
                  height: uiHelper.mediaH(context: context, size: 0.3),
                  color: Color(0xFFFFA500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: uiHelper.mediaH(context: context, size: 0.8),
                        height: uiHelper.mediaH(context: context, size: 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            uiHelper.robotoText(t1: '${(today.month).toString()}월 ${(today.day).toString()}일 ($weekday)',
                                w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Colors.white),
                          ],
                        ),
                      ),
                      Expanded(child: Container(
                        width: uiHelper.mediaH(context: context, size: 0.9),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            uiHelper.robotoText(t1: '${00} : ${00} : ${00}', w: FontWeight.w700, size: 60, s: FontStyle.normal, c: Colors.white),
                          ],
                        ),
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 32,),
                Expanded(
                    child: Container(
                      width: uiHelper.mediaW(context: context, size: 0.9),
                      child: ListView.builder(
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          return _subjectTimer(index, subjects[index]);
                        },
                      ),
                    )
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: Color(0xFFFFA500),
                borderRadius: BorderRadius.circular(200)
              ),
              child: IconButton(onPressed: _addSubject, icon: Icon(Icons.add, color: Colors.white, size: 25,)),
            ),
          )
        ],
      ),
    );
  }

  Widget _subjectTimer(int index, String subject) =>
      Container(
        width: uiHelper.mediaW(context: context, size: 0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFF94B9F3),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Image.asset('assets/images/play_icon.png', width: 10, height: 10,),
                ),
                SizedBox(width: 14,),
                uiHelper.robotoText(t1: subject, w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Color(0xFf333333))
              ],
            ),
            Row(
              children: [
                uiHelper.robotoText(t1: '00', w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Color(0xFf333333)),
                uiHelper.robotoText(t1: ' : ', w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Color(0xFf333333)),
                uiHelper.robotoText(t1: '00', w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Color(0xFf333333)),
                uiHelper.robotoText(t1: ' : ', w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Color(0xFf333333)),
                uiHelper.robotoText(t1: '00', w: FontWeight.w700, size: 20, s: FontStyle.normal, c: Color(0xFf333333)),
                Container(
                  width: 40,
                  height: 40,
                  child: IconButton(onPressed: () => _showCustomDialog(index), icon: Icon(Icons.more_vert)),
                )
              ],
            ),
          ],
        ),
      );

  void _showCustomDialog(int index) {
    showDialog(
      context: context,
      barrierDismissible: true, // 배경을 눌러서 닫을 수 있게 할지 여부
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 박스 모서리 둥글게
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            width: uiHelper.mediaW(context: context, size: 0.33),
            height: uiHelper.mediaH(context: context, size: 0.18),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // 다이얼로그 크기를 내용에 맞춤
              children: [
                ListTile(
                  title: uiHelper.robotoText(t1: '과목 수정',
                      w: FontWeight.w500,
                      size: 20,
                      s: FontStyle.normal,
                      c: Colors.black),
                  onTap: () {
                    Navigator.of(context).pop();
                    _editSubject(index);
                  },
                ),
                ListTile(
                  title: uiHelper.robotoText(t1: '과목 삭제',
                      w: FontWeight.w500,
                      size: 20,
                      s: FontStyle.normal,
                      c: Colors.black),
                  onTap: () {
                    Navigator.of(context).pop();
                    _deleteSubject(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
