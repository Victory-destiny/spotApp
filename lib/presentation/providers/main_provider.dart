import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final mainProvider = MainProvider();

class MainProvider extends ChangeNotifier {
  int startIndex = 0;
  int currentTabIndex = 0;
  PageController pageController = PageController();
  late SharedPreferences _repo;

  //초기화
  Future<void> initSharedPreferences() async {
    _repo = await SharedPreferences.getInstance();
  }

  //저장 String
  Future<void> saveStringData(String key, String value) async {
    _repo.setString(key, value);
  }

  //저장 int
  Future<void> saveIntData(String key, int value) async {
    _repo.setInt(key, value);
  }

  //저장 StringList
  Future<void> saveStringListData(String key, List<String> value) async {
    _repo.setStringList(key, value);
  }

  //불러오기 String
  Future<String?> loadStrongData(String key) async {
    final myData = _repo.getString(key); //Click
    return myData;
  }

  //불러오기 int
  Future<int?> loadIntData(String key) async {
    final myData = _repo.getInt(key); //Click
    return myData;
  }

  //불러오기 StringList
  Future<List<String>?> loadStringListData(String key) async {
    final myData = _repo.getStringList(key); //Click
    return myData;
  }

  void see({required String t1}) async {
    final load = await mainProvider.loadStrongData(t1);
    print(load);
  }

  void changeTabIndex(int index) {
    currentTabIndex = index;
    pageController.jumpToPage(currentTabIndex);
    notifyListeners();
  }

  void addStart() {
    if(startIndex != 4) {
      startIndex++;
    }
    // pageController.animateToPage(
    //   startIndex,
    //   duration: const Duration(milliseconds: 300), // 애니메이션 시간
    //   curve: Curves.easeInOut, // 자연스러운 곡선
    // );
    pageController.jumpToPage(startIndex);
    notifyListeners();
  }

  void deleteStart() {
    if(startIndex != 0) {
      startIndex--;
    }
    // pageController.animateToPage(
    //   startIndex,
    //   duration: const Duration(milliseconds: 300), // 애니메이션 시간
    //   curve: Curves.easeInOut, // 자연스러운 곡선
    // );
    pageController.jumpToPage(startIndex);
    notifyListeners();
  }

  void moveStless({required BuildContext context, required StatelessWidget route}) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionDuration: Duration.zero, // 애니메이션 지속 시간 0으로 설정
        reverseTransitionDuration: Duration.zero, // 뒤로가기 애니메이션도 0으로 설정
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 효과 없이 바로 페이지 보여줌
        },
      ),
    );
  }

  void moveStful({required BuildContext context, required StatefulWidget route}) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionDuration: Duration.zero, // 애니메이션 지속 시간 0으로 설정
        reverseTransitionDuration: Duration.zero, // 뒤로가기 애니메이션도 0으로 설정
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // 애니메이션 효과 없이 바로 페이지 보여줌
        },
      ),
    );
  }

}