import 'dart:io';

import 'package:fake_vision/providers/user_provider.dart';
import 'package:fake_vision/resources/firestore_methods.dart';
import 'package:fake_vision/theme/theme_helper.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/custom_text_style.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file; //it can be null
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadURL;
  String _postType = 'video';

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  Widget _videoPreviewWidget() {
    if (_controller != null) {
      return SizedBox(
        height: 200,
        width: 200,
        child: AspectRatio(
          aspectRatio: 387 / 351,
          child: Container(child: VideoPlayer(_controller!)),
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

// Function to upload video to Firebase and post it
  void postVideo(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Post video with description to Firestore
      String res = await FirestoreMethods().uploadVideo(
          _descriptionController.text,
          _videoURL!,
          uid,
          username,
          profImage,
          _postType!);

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        // Show success dialog
        successDialogBox(
          context,
          "Success",
          "Posted Successfully",
        );

        clearImageOrVideo();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  _selectImageOrVideo(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: blueColor,
          title: const Text(
            'Create a Post',
            style: TextStyle(fontFamily: 'Inter', color: whiteColor),
          ),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose Image from Gallery',
                    style: TextStyle(fontFamily: 'Inter', color: whiteColor)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                    _postType = 'image';
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose Video from Gallery',
                    style: TextStyle(fontFamily: 'Inter', color: whiteColor)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _videoURL = await pickVideo();
                  _initializeVideoPlayer();
                }),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  decoration: BoxDecoration(
                    color: redColor, // Set the background color to red
                    borderRadius: BorderRadius.circular(35), // Rounded corners
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color:
                          Colors.white, // Text color, white for better contrast
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid,
          username,
          profImage,
          _postType!);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        successDialogBox(
          context,
          "Success",
          "Posted Successfully",
        );

        clearImageOrVideo();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImageOrVideo() {
    setState(() {
      _file = null;
      _videoURL = null;
      if (_controller != null) {
        _controller!.pause(); // Pause the video if it's playing
        _controller!.dispose(); // Dispose of the video player controller
        _controller = null; // Set the controller to null
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return _file != null
        ? Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: colorStatusBar, // Set the status bar color
                statusBarIconBrightness:
                    Brightness.light, // Status bar icons' color
              ),
              flexibleSpace: Stack(
                children: [
                  // Clipping the background image to the bounds of the AppBar
                  ClipRect(
                    child: Positioned.fill(
                      child: Container(),
                    ),
                  ),
                  // Actual AppBar content

                  Padding(
                    padding: EdgeInsets.only(
                      left: 55.0,
                      top: MediaQuery.of(context).size.width > webScreenSize
                          ? 17.0
                          : 44.0,
                    ),
                    child: Row(
                      children: [
                        // Add some spacing
                        Text(
                          "Post to",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.cancel_sharp,
                ),
                onPressed: clearImageOrVideo,
              ),
              centerTitle: false,
              actions: <Widget>[
                TextButton(
                  onPressed: () => postImage(
                    userProvider.getUser.uid,
                    userProvider.getUser.username,
                    userProvider.getUser.photoUrl,
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Inter'),
                  ),
                )
              ],
            ),
            // POST FORM
            body: Column(
              children: <Widget>[
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            userProvider.getUser.photoUrl,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                                hintText: "What do you want to talk about?",
                                hintStyle: TextStyle(fontFamily: 'Inter'),
                                border: InputBorder.none),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 140.0,
                      width: 135.0,
                      child: AspectRatio(
                        aspectRatio: 387 / 351,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : _controller != null
            ? Scaffold(
                appBar: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: colorStatusBar, // Set the status bar color
                    statusBarIconBrightness:
                        Brightness.light, // Status bar icons' color
                  ),
                  flexibleSpace: Stack(
                    children: [
                      // Clipping the background image to the bounds of the AppBar
                      ClipRect(
                        child: Positioned.fill(
                          child: Container(),
                        ),
                      ),
                      // Actual AppBar content

                      Padding(
                        padding: const EdgeInsets.only(left: 55.0, top: 44.0),
                        child: Row(
                          children: [
                            SizedBox(width: 8.0), // Add some spacing
                            Text(
                              "Post to",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter',
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.cancel_sharp,
                    ),
                    onPressed: clearImageOrVideo,
                  ),
                  centerTitle: false,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => postVideo(
                        userProvider.getUser.uid,
                        userProvider.getUser.username,
                        userProvider.getUser.photoUrl,
                      ),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            fontFamily: 'Inter'),
                      ),
                    )
                  ],
                ),
                // POST FORM
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      isLoading
                          ? const LinearProgressIndicator()
                          : const Padding(padding: EdgeInsets.only(top: 0.0)),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userProvider.getUser.photoUrl,
                                ),
                              ),
                              TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                    hintText: "What do you want to talk about?",
                                    hintStyle: TextStyle(fontFamily: 'Inter'),
                                    border: InputBorder.none),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          _videoURL != null
                              ? _videoPreviewWidget()
                              : const Text("No Video Selected"),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Images/bg13.png'), fit: BoxFit.fill),
                  ),
                  padding: width > webScreenSize
                      ? EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 5)
                      : const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 220),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [blue, green],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: Text(
                          'Upload Image/Video',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'Inter',
                            // The color must be set to white for the gradient to show
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        textColor: whiteColor,
                        fontSize: 16,
                        title:
                            "Upload Image or Video to create deepfake awareness among community",
                        textOverFlow: TextOverflow.ellipsis,
                        maxline: 5,
                      ),
                      Lottie.asset(
                        'Images/upload.json',
                        height: 150,
                        width: 150,
                      ),
                      InkWell(
                        onTap: () => _selectImageOrVideo(context),
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
                                  Color.fromARGB(
                                      255, 106, 175, 169) // dark blue
                                ]),
                          ),
                          child: !_isLoading
                              ? Text(
                                  'Upload',
                                  style: smallTextStyle,
                                )
                              : const CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
