import 'package:flutter/material.dart';

final uiHelper = UIHelper();

class UIHelper{

  Text robotoText({required String t1, required FontWeight w, required double size,
  required FontStyle s, required Color c}) {
    return Text(t1, style: TextStyle(
      fontWeight: w,
      fontFamily: 'Roboto',
      fontSize: size,
      fontStyle: s,
      color: c,
    ),);
  }

  double mediaW({required BuildContext context, required double size}) {
    return MediaQuery.of(context).size.width * size;
  }

  double mediaH({required BuildContext context, required double size}) {
    return MediaQuery.of(context).size.height * size;
  }

}