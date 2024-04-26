import 'dart:convert';
import 'dart:io';

import 'package:fake_vision/screens/output_screen.dart';
import 'package:fake_vision/theme/theme_helper.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ScanImage extends StatefulWidget {
  const ScanImage({super.key});

  @override
  State<ScanImage> createState() => _ScanImageState();
}

class _ScanImageState extends State<ScanImage> {
  bool _isLoading = false;
  Uint8List? _image;
  String image_path='';
  String output = '';
  var data;

  // Initialize video player
  late VideoPlayerController _videoController;

  void initState() {
    super.initState();
    // Set the status bar color when the screen is created
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorStatusBar, // Set your desired status bar color
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scan() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // Simulating some asynchronous task
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the OutputScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OutputScreen()),
    );

    // set loading to false after navigation
    setState(() {
      _isLoading = false;
    });
  }
Future<void> _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        image_path = file.path!;
      });
    }
  }
 

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/bg13.png'), fit: BoxFit.fill),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [blue, green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  'Scan & Detect Deepfake Images',
                  style: TextStyle(
                    fontSize: 34.0,
                    fontFamily: 'Inter',
                    // The color must be set to white for the gradient to show
                    color: Colors.white,
                  ),
                ),
              ),

              Text(
                "Upload Image",
                style: TextStyle(
                    fontFamily: 'Inter', fontSize: 20, color: whiteColor),
              ),

              IconButton(
                      icon: Image.asset('Images/upload_image.png',
                          width: 300, height: 250),
                      onPressed: _selectImage,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top:15,left:8.0,right:8,bottom:15),
                    child: Text(image_path, style: theme.textTheme.bodyMedium),
                  ),
              InkWell(
                onTap: scan,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
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
                          'Scan',
                          style: theme.textTheme.bodyMedium,
                        )
                      : const CircularProgressIndicator(
                          color: whiteColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              //Flexible: This widget wraps around a child widget to give it flexibility in terms of how it takes up space within a Row, Column, or Flex parent.
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
