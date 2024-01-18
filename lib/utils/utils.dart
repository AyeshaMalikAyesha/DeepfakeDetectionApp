import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fake_vision/responsive/mobile_screen_layout.dart';
import 'package:fake_vision/responsive/responsive_layout_screen.dart';
import 'package:fake_vision/responsive/web_screen_layout.dart';
import 'package:fake_vision/screens/login_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(fontFamily: 'Inter'),
      ),
    ),
  );
}

Future successDialogBox(
  BuildContext context,
  String text,
  String contentText,
) async {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    animType: AnimType.BOTTOMSLIDE,
    title: text,
    titleTextStyle: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
        fontSize: 20),
    desc: contentText,
    descTextStyle: TextStyle(fontFamily: 'Inter', color: whiteColor),
    btnOkText: "Ok",
    padding: EdgeInsets.only(left: 50, right: 50),
    btnOkColor: green,
    buttonsBorderRadius: BorderRadius.circular(25),
    buttonsTextStyle: TextStyle(fontFamily: 'Inter', color: whiteColor),
    dialogBackgroundColor: blueColor,
    btnOkOnPress: () {
      // Now, navigate to the next screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
        (route) => false,
      );
    },
  )..show();
}

Future errorDialogBox(
  BuildContext context,
  String titleText,
  String contentText,
) async {
  AlertDialog alert = AlertDialog(
    backgroundColor: blueColor,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: redColor,
          size: 30,
        ),
        Text(titleText, style: TextStyle(color: redColor, fontFamily: 'Inter')),
      ],
    ),
    content: Text(contentText,
        style: TextStyle(color: whiteColor, fontSize: 15, fontFamily: 'Inter')),
    actions: [
      TextButton(
          onPressed: () {
            // Now, navigate to the next screen
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
          child: Text("Ok",
              style: TextStyle(
                  color: whiteColor, fontSize: 18, fontFamily: 'Inter')))
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

class CustomSocialButton extends StatelessWidget {
  final Image icon_img;
  const CustomSocialButton({super.key, required this.icon_img});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: icon_img),
    );
  }
}
