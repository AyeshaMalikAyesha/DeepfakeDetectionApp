import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {
  CustomText({
    this.fontWeight = FontWeight.normal,
    required this.textColor,
    required this.fontSize,
    required this.title,
    required this.maxline,
    required this.textOverFlow,
    this.textAlign = TextAlign.center,
    this.textStyle = GoogleFonts.quicksand,
  });

  FontWeight fontWeight;
  Color textColor;
  double fontSize;
  String title;
  TextAlign textAlign;
  final textStyle, maxline, textOverFlow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: function,
      child: Text(
        title,
        overflow: textOverFlow,
        maxLines: maxline,
        style: textStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
        textAlign: textAlign,
      ),
    );
  }
}

