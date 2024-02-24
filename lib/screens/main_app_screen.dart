import 'package:fake_vision/responsive/mobile_screen_layout.dart';
import 'package:fake_vision/responsive/responsive_layout_screen.dart';
import 'package:fake_vision/responsive/web_screen_layout.dart';
import 'package:fake_vision/screens/login_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //streambuilder widget is used to display dynamic, real time data
    return StreamBuilder(
      //Using FirebaseAuth.instance.authStateChanges() in a StreamBuilder show a login page to unauthenticated users and a home screen to authenticated users.
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }
        return const LoginScreen();
      },
    );
  }
}
