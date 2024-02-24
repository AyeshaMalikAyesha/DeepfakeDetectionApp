import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double paddingTop;
  final Widget backButtonScreen;

  CustomAppBar({
    Key? key,
    required this.title,
    this.paddingTop = 0.0,
    required this.backButtonScreen,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorStatusBar,
        statusBarIconBrightness: Brightness.light,
      ),
      automaticallyImplyLeading: false,
      elevation: 5.0,
      flexibleSpace: Stack(
        children: [
          ClipRect(
            child: Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Images/bg2.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 34, 34, 34).withOpacity(0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 1.0, top: paddingTop),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => backButtonScreen),
                    );
                  },
                ),
                SizedBox(width: 7.0), // Add some spacing
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 17, color: whiteColor, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
