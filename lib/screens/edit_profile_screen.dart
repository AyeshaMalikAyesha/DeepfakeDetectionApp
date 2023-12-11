import 'package:fake_vision/screens/profile_screen.dart';
import 'package:fake_vision/utils/app_export.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/widgets/app_bar/appbar_leading_image.dart';
import 'package:fake_vision/widgets/app_bar/custom_app_bar.dart';
import 'package:fake_vision/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  static String profileImg = 'Images/defaultProfileImg.png';

  static String cameraImg = 'Images/img_solar_camera_mi.svg';

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

  void scan() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // Navigate to the ProfileScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => ProfileScreen(
                uid: FirebaseAuth.instance.currentUser!.uid,
              )),
    );

    // set loading to false after navigation
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Images/bg13.png'), fit: BoxFit.fill),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.v),
              child: Column(
                children: [
                  _buildAppBar(context),
                  SizedBox(height: 45.v),
                  SizedBox(
                    height: 175.v,
                    width: 171.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          imagePath: profileImg,
                          height: 170.v,
                          width: 165.h,
                          radius: BorderRadius.circular(
                            85.h,
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 175.v,
                            width: 171.h,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CustomImageView(
                                  imagePath: cameraImg,
                                  height: 32.adaptSize,
                                  width: 32.adaptSize,
                                  alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(
                                    right: 30.h,
                                    bottom: 15.v,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Name",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildName(context),
                  SizedBox(height: 14.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Bio",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.v),
                  _buildBio(context),
                  SizedBox(height: 15.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Password",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildPassword(context),
                  SizedBox(height: 14.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Text(
                        "Confirm Password",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildConfirmPassword(context),
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

  // Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 55.h,
        leading: AppbarLeadingImage(
          imagePath: backBtn,
          onTap: scan,
          margin: EdgeInsets.only(left: 25.h),
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: theme.textTheme.titleLarge,
        ));
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: TextFieldInput(
          hintText: 'Enter your username',
          textInputType: TextInputType.text,
          textEditingController: _nameController,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBio(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: TextFieldInput(
          hintText: 'Change Bio',
          textInputType: TextInputType.text,
          textEditingController: _passwordController,
        ),
      ),
    );
  }

  // Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: TextFieldInput(
          hintText: 'Change Password',
          textInputType: TextInputType.text,
          textEditingController: _passwordController,
        ),
      ),
    );
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        child: TextFieldInput(
          hintText: 'Confirm Password',
          textInputType: TextInputType.text,
          textEditingController: _passwordController,
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
