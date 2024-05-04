import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/widgets/custom_button.dart';
import 'package:fake_vision/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//stateless widgets are immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWebSize = MediaQuery.of(context).size.width < webScreenSize;

    return Scaffold(
        body: isWebSize
            ? Container(
                //full width of device
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Images/bg13.png'),
                    fit: BoxFit.fill,
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
                            textOverFlow: TextOverflow.ellipsis,
                            maxline: 5,
                          ),
                        )
                      ],
                    ),
                    SizedBox(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: SwipeableButton(),
                    )
                  ],
                ),
              )
            : Container(
                //full width of device
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Images/bg16.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Image(
                        height: 150,
                        image: AssetImage(
                          "Images/app_logo-removebg.png",
                        ),
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 200, vertical: 5),
                        child: SwipeableButton(),
                      )
                    ],
                  ),
                ),
              ));
  }
}
