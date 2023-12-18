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
      content: Text(text),
    ),
  );
}

Future successDialogBox(BuildContext context, String text) async {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: "Success",
    desc: text,
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
    btnCancelOnPress: () {},
  )..show();
}

Future errorDialogBox(BuildContext context, String text) async {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: "Error",
    desc: text,
    btnOkOnPress: () {
      // Now, navigate to the next screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    },
    btnCancelOnPress: () {},
  )..show();
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
