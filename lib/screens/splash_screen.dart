import 'package:fake_vision/widgets/custom_button.dart';
import 'package:fake_vision/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//stateless widgets are immutable 
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Scaffold is useful widget that is used to create basic app structure
    return Scaffold(
      body: Container(
        width: double.infinity,//container will occupy as much horizontal space as its parent
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
            // any text that overflows and doesn't fit in the available space is replaced with an ellipsis (...)
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
