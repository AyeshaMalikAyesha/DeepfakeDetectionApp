import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  //late keyword is used to indicate that a variable will be initialized at a later point
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
 
  void navigationTapped(int page) {
    //Animating Page or change page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    //AnnotatedRegion<SystemUiOverlayStyle> in Flutter is a widget used to change the appearance of system overlays, specifically the status bar and the navigation bar
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
  
        systemNavigationBarColor: colorNavBar,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(gradient: navColor),
          //CupertinoTabBar is a widget that provides a bottom tab bar with iOS look and style.
          child: CupertinoTabBar(
            inactiveColor: whiteColor,
            activeColor: seaGreen,
            backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  'Images/face-detection.png',
                  width: 25,
                  color: (_page == 0) ? seaGreen : whiteColor,
                ),
                label: 'Scan',
                backgroundColor: primaryColor,
                // Change the color here
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: (_page == 1) ? seaGreen : whiteColor,
                  ),
                  label: 'Search',
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    size: 30,
                    color: (_page == 2) ? seaGreen : whiteColor,
                  ),
                  label: 'Post',
                  backgroundColor: primaryColor),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  size: 30,
                  color: (_page == 3) ? seaGreen : whiteColor,
                ),
                label: 'Community',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                  color: (_page == 4) ? seaGreen : whiteColor,
                ),
                label: 'Profile',
                backgroundColor: primaryColor,
              ),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}
