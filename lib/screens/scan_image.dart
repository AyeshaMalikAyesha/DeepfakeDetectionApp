import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fake_vision/screens/output_screen.dart';
import 'package:fake_vision/theme/theme_helper.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ScanImage extends StatefulWidget {
  const ScanImage({super.key});

  @override
  State<ScanImage> createState() => _ScanImageState();
}

class _ScanImageState extends State<ScanImage> {
  final TextEditingController _linkController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  String videoPath = 'https://www.example.com/';
  String output = 'Initial Output';
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
    _linkController.dispose();
    // Dispose of the video player when the widget is disposed.
    _videoController.dispose();
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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  Future<void> _selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        videoPath = file.path!;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('Images/app_logo-removebg.png',
                  width: 140, height: 140),
              Flexible(
                flex: 0,
                child: Container(),
              ),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [blue, green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  'Scan & Detect Deepfakes',
                  style: TextStyle(
                    fontSize: 34.0,
                    fontFamily: 'Inter',
                    // The color must be set to white for the gradient to show
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Upload Image",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: whiteColor,
                ),
                child: TextField(
                  controller: _linkController,
                  decoration: InputDecoration(
                    hintText: videoPath,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: _selectVideo,
                      icon: const Icon(Icons.file_upload),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    // No need to update the URL here
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () async {
                  if (videoPath.isNotEmpty) {
                    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:5000/predict_video'));
    
    // Add the video file to the request
    request.files.add(await http.MultipartFile.fromPath('file', videoPath));

    // Send the request
    var streamedResponse = await request.send();
    
    // Get the response
    var response = await http.Response.fromStream(streamedResponse);
    
    // Parse the response data
    var decoded = jsonDecode(response.body);
    
    // Update the output state
    setState(() {
      output = decoded['output'];
    });
                  } else {
                    // Show an error message or handle the case where no video is selected
                    print("No Image selected");
                  }
                },
                child: Text(
                  'Scan',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                output,
                style: TextStyle(fontSize: 40, color: Colors.green),
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
