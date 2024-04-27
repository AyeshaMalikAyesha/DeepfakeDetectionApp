import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_vision/resources/auth_methods.dart';
import 'package:fake_vision/responsive/mobile_screen_layout.dart';
import 'package:fake_vision/screens/edit_profile_screen.dart';
import 'package:fake_vision/screens/login_screen.dart';
import 'package:fake_vision/utils/app_export.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/app_bar/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  static String backgroundImg = 'Images/Fake.png';
  static String backBtn = 'Images/img_material_symbol_onprimary.svg';
  int postLength = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
     
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();

      postLength = postSnap.docs.length;
      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void signoutUser() async {
    setState(() {
      _isLoading = true;
    });

    AwesomeDialog(
        context: context,
        dialogType: DialogType.noHeader,
        animType: AnimType.BOTTOMSLIDE,
        title: "Confirmation",
        titleTextStyle: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 20),
        desc: "Log out of your account?",
        descTextStyle: TextStyle(fontFamily: 'Inter', color: whiteColor),
        btnCancelText: "Cancel",
        buttonsTextStyle: TextStyle(fontFamily: 'Inter', color: whiteColor),
        btnCancelColor: const Color.fromARGB(255, 167, 207, 240),
        btnCancelOnPress: () {
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                ),
              ),
            );
          }
        },
        btnOkText: "Logout",
        buttonsBorderRadius: BorderRadius.circular(25),
        btnOkColor: redColor,
        dialogBackgroundColor: blueColor,
        btnOkOnPress: signout)
      ..show();
  }

  void signout() async {
    await AuthMethods().signOut();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  void editProfile() async {
    setState(() {
      _isLoading = true;
    });

    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EditProfileScreen(uid: widget.uid),
        ),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'Profile',
                paddingTop: 5,
                backButtonScreen: MobileScreenLayout(),
              ),
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _buildProfileImg(context),
                      SizedBox(height: 9.v),
                      Text(
                        userData['username'],
                        style: CustomTextStyles.titleMediumPrimary,
                      ),
                      SizedBox(height: 7.v),
                      Text(
                        userData['bio'],
                        style: theme.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 129.h),
                        ),
                      ),
                      SizedBox(height: 11.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 74.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(
                              flex: 50,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildStatColumn(postLength, "posts"),
                              ],
                            ),
                            Spacer(
                              flex: 50,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13.v),
                      Visibility(
                        visible: FirebaseAuth.instance.currentUser!.uid ==
                            widget.uid,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: editProfile,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 100,
                                margin:
                                    const EdgeInsets.only(top: 12, left: 70),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(
                                            53, 102, 172, 1), // light blue
                                        Color.fromARGB(
                                            255, 106, 175, 169) // dark blue
                                      ]),
                                ),
                                child: !_isLoading
                                    ? Text(
                                        'Edit Profile',
                                        style: theme.textTheme.titleSmall,
                                      )
                                    : const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                              ),
                            ),
                            InkWell(
                              onTap: signoutUser,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 100,
                                margin:
                                    const EdgeInsets.only(top: 12, right: 70),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(
                                            53, 102, 172, 1), // light blue
                                        Color.fromARGB(
                                            255, 106, 175, 169) // dark blue
                                      ]),
                                ),
                                child: !_isLoading
                                    ? Text(
                                        'Sign out',
                                        style: theme.textTheme.titleSmall,
                                      )
                                    : const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 28.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 31.h,
                          right: 80.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.v, left: 0.1),
                              child: Text(
                                "Posts",
                                style: CustomTextStyles.titleSmallPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Divider(
                        indent: 5.h,
                        endIndent: 5.h,
                        color: Colors.grey,
                      ),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 1.5,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap =
                                  (snapshot.data! as dynamic).docs[index];

                              // Check the type of post
                              if (snap['postType'] == 'image') {
                                // Display image
                                return SizedBox(
                                  child: Image(
                                    image: NetworkImage(snap['postUrl']),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else if (snap['postType'] == 'video') {
                                // Display video
                                return VideoWidget(videoUrl: snap['postUrl']);
                              } else {
                                // Handle other types of posts or unknown types
                                return Container(
                                  color: Colors.red,
                                  child: Center(
                                    child: Text('Unsupported post type'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                fontFamily: 'Inter'),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildProfileImg(BuildContext context) {
    return SizedBox(
      height: 132.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
              userData['photoUrl'],
            ),
            radius: 50,
          ),
        ],
      ),
    );
  }
}
