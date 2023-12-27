import 'package:fake_vision/responsive/responsive_admin.dart';
import 'package:fake_vision/screens/dashboard/dashboard_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  void initState() {
    super.initState();

    // Set the status bar color when the screen is created
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: colorStatusBar, // Set your desired status bar color
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: colorStatusBar,
        systemNavigationBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),

      backgroundColor: blueColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
