import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_vision/screens/profile_screen.dart';
import 'package:fake_vision/utils/app_export.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/app_bar/custom_app_bar.dart';
import 'package:fake_vision/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final String uid;
  EditProfileScreen({Key? key, required this.uid})
      : super(
          key: key,
        );

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var userData = {};
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _loading = false;
  static String backBtn = 'Images/backBtn.png';

  static String cameraImg = 'Images/img_solar_camera_mi.svg';
  Uint8List? _image;
  String _imageUrl = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

      userData = userSnap.data()!;
      _nameController.text = userData['username'];
      _bioController.text = userData['bio'];
      _imageUrl = userData['photoUrl'];

      // Load the image asynchronously and set it to _image
      _image = await loadImageFromUrl(_imageUrl);

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

  Future<Uint8List?> loadImageFromUrl(String imageUrl) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Fetch the image from the URL
      http.Response response = await http.get(Uri.parse(imageUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the response body to Uint8List
        Uint8List imageBytes = response.bodyBytes;
        return imageBytes;
      } else {
        // Handle error
        showSnackBar(
            context, 'Failed to load image from URL: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
        return null;
      }
    } catch (e) {
      // Handle error
      print('Error loading image from URL: $e');
      setState(() {
        _isLoading = false;
      });
      return null;
    }
  }

  void saveChanges() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      // Password and confirm password do not match
      showSnackBar(context, 'Password and Confirm Password do not match');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_image != null) {
        // Upload the new image to Firebase Storage
        await updateProfileImage(_image!);
      }
      if (_passwordController.text != '') {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(_passwordController.text);
      }
      // Update user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({
        'username': _nameController.text,
        'bio': _bioController.text,
      });
      // Fetch posts data where uid matches
      QuerySnapshot postsSnapshot =
          await FirebaseFirestore.instance.collection('posts').get();

      List<Map<String, dynamic>> postsData = [];

      for (QueryDocumentSnapshot postDoc in postsSnapshot.docs) {
        // Get the data of the post
        Map<String, dynamic>? postData =
            postDoc.data() as Map<String, dynamic>?;

        if (postData != null) {
          // Check if the uid matches
          if (postData['uid'] == widget.uid) {
            // Get the reference to the post document
            DocumentReference postRef =
                FirebaseFirestore.instance.collection('posts').doc(postDoc.id);

            // Update username and bio in the post document
            await postRef.update({
              'username': _nameController.text,
              'bio': _bioController.text,
              'profileImage':_imageUrl,
              
            });
          }
        }
      }

      // Navigate back to the profile screen after saving changes
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ),
      );
    } catch (e) {
      // Handle error
      print('Error saving changes: $e');
      showSnackBar(context, 'Error saving changes');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> updateProfileImage(Uint8List image) async {
    try {
      // Generate a unique filename for the image
      String fileName =
          'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Upload the image to Firebase Storage
      TaskSnapshot uploadSnapshot = await FirebaseStorage.instance
          .ref('profile_images/$fileName')
          .putData(image);

      // Get the download URL of the uploaded image
      _imageUrl = await uploadSnapshot.ref.getDownloadURL();

      // Update the 'photoUrl' field in Firestore for the current user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'photoUrl': _imageUrl});

      // If needed, you can also update the local _image variable to display the new image
      setState(() {
        _image = image;
      });

      // Optionally, you can show a success message or perform any other actions
      print('Profile image updated successfully');
    } catch (e) {
      // Handle error
      print('Error updating profile image: $e');
      throw e;
    }
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

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
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
                          image: AssetImage('Images/bg13.png'),
                          fit: BoxFit.fill),
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
                              CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor:
                                    Color.fromARGB(255, 54, 114, 244),
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
                          textEditingController: _confirmPasswordController,
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
      onTap: saveChanges,
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
