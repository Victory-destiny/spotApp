import 'package:flutter/material.dart';
import 'package:spot/presentation/providers/main_provider.dart';
import 'package:spot/presentation/providers/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  bool isLoaded = false; // 데이터가 로드되었는지 추적하는 변수

  @override
  void initState() {
    super.initState();
    mainProvider.initSharedPreferences();
    initcont(); // 비동기적으로 데이터 로딩
  }

  @override
  void dispose() {
    super.dispose();
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
      appBar: PreferredSize(preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: null,
          flexibleSpace: Container(
            alignment: Alignment.centerLeft,
            height: 60 + MediaQuery.of(context).padding.top,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: uiHelper.mediaW(context: context, size: 0.05),),
                uiHelper.robotoText(t1: 'SPOT', w: FontWeight.w900,
                    size: 30, s: FontStyle.italic, c: Color(0xFFFFA500))
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: uiHelper.mediaW(context: context, size: 0.05)),
        child: Column(
          children: [
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


          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(

        onTap: mainProvider.changeTabIndex,
        currentIndex: mainProvider.currentTabIndex,
        items: [
          _buildBottomNavBarItem(icon: Icons.home_outlined),
          _buildBottomNavBarItem(icon: Icons.schedule),
          _buildBottomNavBarItem(icon: Icons.chat),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwMaQzhtKfYo9TEeuiSLBjz3isqfjhuU0SoiVqid_t636C4XO_BQt4h1Rf2eWUrv5iL2o&usqp=CAU')
                  )
              ),
            ),
            icon: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwMaQzhtKfYo9TEeuiSLBjz3isqfjhuU0SoiVqid_t636C4XO_BQt4h1Rf2eWUrv5iL2o&usqp=CAU')
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({required IconData icon}) =>
      BottomNavigationBarItem(
        icon: Icon(icon, color: Colors.black),
        // activeIcon: Icon(activeIcon, color: Colors.black),
        label: '',
      );
}
