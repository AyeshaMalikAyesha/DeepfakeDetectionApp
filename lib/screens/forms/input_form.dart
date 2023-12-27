import 'package:fake_vision/screens/forms/components/add_new_widget.dart';
import 'package:fake_vision/screens/home/home_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<FormMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorStatusBar, // Set the status bar color
          statusBarIconBrightness: Brightness.light, // Status bar icons' color
        ),
        automaticallyImplyLeading: false,
        elevation: 5.0, //shadow to app bar
        flexibleSpace: Stack(
          children: [
            // Clipping the background image to the bounds of the AppBar
            ClipRect(
              child: Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Images/bg2.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 34, 34, 34)
                            .withOpacity(0.5), // This controls the black tint
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Actual AppBar content
            Padding(
              padding: const EdgeInsets.only(left: 1.0, top: 30),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  SizedBox(width: 8.0), // Add some spacing
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: blueColor,
          elevation: 5,
          margin: EdgeInsets.fromLTRB(32, 32, 64, 32),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Add New Admin?",
                        style: customTextStyle,
                      ),
                    ),
                    SelectionSection(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
