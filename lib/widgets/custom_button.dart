import 'package:fake_vision/screens/main_app_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:fake_vision/screens/splash_screen.dart';

class SwipeableButton extends StatefulWidget {
  const SwipeableButton({super.key});

  @override
  State<SwipeableButton> createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(142, 186, 247, 1), // light blue
              Color(0xFF003366) // dark blue
            ]),
      ),
      child: SwipeableButtonView(
        buttonText: "Get Started",
        buttontextstyle: TextStyle(
          fontSize: 18,
          fontFamily: 'Inter',
          color: whiteColor
        ),
        buttonWidget: Container(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          ),
        ),
        activeColor: Color.fromARGB(1, 118, 179, 226),
        isFinished: isFinished,
        onWaitingProcess: () {
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isFinished = true;
            });
          });
        },
        onFinish: () async {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: MainAppScreen(),
            ),
          );
          setState(() {
            isFinished = false;
          });
        },
      ),
    );
  }
}
