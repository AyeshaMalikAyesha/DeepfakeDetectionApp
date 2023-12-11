import 'package:fake_vision/responsive/mobile_screen_layout.dart';
import 'package:fake_vision/responsive/responsive_layout_screen.dart';
import 'package:fake_vision/responsive/web_screen_layout.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FakeVision',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout()));
  }
}
