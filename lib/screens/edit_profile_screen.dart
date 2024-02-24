import 'dart:typed_data';

import 'package:fake_vision/screens/profile_screen.dart';
import 'package:fake_vision/utils/app_export.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/app_bar/custom_app_bar.dart';
import 'package:fake_vision/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  static String backBtn = 'Images/backBtn.png';

  static String cameraImg = 'Images/img_solar_camera_mi.svg';
  Uint8List? _image;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void SaveChanges() async {
    setState(() {
      _isLoading = true;
    });
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: 'Edit Profile',
          paddingTop: 5,
          backButtonScreen: ProfileScreen(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ),
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Images/bg13.png'), fit: BoxFit.fill),
              ),
              padding: MediaQuery.of(context).size.width > webScreenSize
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3)
                  : const EdgeInsets.symmetric(horizontal: 34),
              //full width of device
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 45.v),
                  SizedBox(
                    height: 175.v,
                    width: 171.h,
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor:
                                    Color.fromARGB(255, 54, 114, 244),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://i.stack.imgur.com/l60Hf.png'),
                                backgroundColor: Colors.blue,
                              ),
                        Positioned(
                          bottom: 15,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 21.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  TextFieldInput(
                    hintText: 'Change Your Name',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _nameController,
                  ),
                  SizedBox(height: 14.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bio",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  TextFieldInput(
                    hintText: 'Change Bio',
                    textInputType: TextInputType.text,
                    textEditingController: _bioController,
                  ),
                  SizedBox(height: 15.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  TextFieldInput(
                    hintText: 'Change Password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 14.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  TextFieldInput(
                    hintText: 'Confirm Password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 14.v),
                  SizedBox(height: 8.v),
                  SizedBox(height: 29.v),
                  _buildSaveChanges(context),
                  SizedBox(height: 31.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveChanges(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(53, 102, 172, 1), // light blue
                Color.fromARGB(255, 106, 175, 169) // dark blue
              ]),
        ),
        child: !_isLoading
            ? Text(
                'Save Changes',
                style: theme.textTheme.titleSmall,
              )
            : const CircularProgressIndicator(
                color: primaryColor,
              ),
      ),
    );
  }
}
