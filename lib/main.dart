import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hawksApp/view/screens/login_page.dart';
import 'package:hawksApp/view/theme/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hawks App',
      theme: _buildTheme(Brightness.light),
      home: LoginPage(),
    );
  }
}
ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);
  return baseTheme.copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Color(ColorT.PrimaryColor),
        centerTitle: true, elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(ColorT.PrimaryColor),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),),focusColor: Color(ColorT.PrimaryColor),primaryColor: Color(ColorT.PrimaryColor),
  );
}