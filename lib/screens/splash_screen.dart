import 'package:fake_vision/widgets/custom_button.dart';
import 'package:fake_vision/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  height: 240.h,
                  image: AssetImage(
                    "Images/app_logo-removebg.png",
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: CustomText(
                    textColor: Color(0xffaeb0af),
                    fontSize: 18.sp,
                    title:
                        "Because Reality Matters: Detecting Deepfakes With Precision.",
                    text0verFlow: TextOverflow.ellipsis,
                    maxline: 5,
                  ),
                )
              ],
            ),
            SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: SwipeableButton(),
            )
          ],
        ),
      ),
    );
  }
}
