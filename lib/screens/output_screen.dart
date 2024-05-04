import 'package:fake_vision/screens/main_app_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OutputScreen extends StatefulWidget {
  String file_path;
  String result;
  String confidence;
  OutputScreen(
      {super.key,
      required this.file_path,
      required this.result,
      required this.confidence});

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Images/bg13.png'), fit: BoxFit.fill)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the  Scan Screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => MainAppScreen()),
                      );
                    },
                    child: Icon(Icons.cancel_sharp,
                        size: 30.0,
                        color: whiteColor // Adjust the size as needed
                        ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                              'Create Post',
                              style: smallTextStyle,
                            )
                          : const CircularProgressIndicator(
                              color: primaryColor,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [blue, green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  'Model Results',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Inter',
                    // The color must be set to white for the gradient to show
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  height: 180, width: 180, child: _guageIndicator(context)),
              SizedBox(width: 90),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      "File:",
                      style: smallTextStyle,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.file_path, // Use widget.file_path here
                          style: smallTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 10),
                      child: Text(
                        "Confidence of Prediction:",
                        style: smallTextStyle,
                      ),
                    ),
                    Text(widget.confidence, style: smallTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 10),
                      child: Text(
                        "Result:",
                        style: smallTextStyle,
                      ),
                    ),
                    widget.result == 'REAL'
                        ? Text(widget.result,
                            style: TextStyle(
                                color: Color.fromARGB(255, 38, 235, 55),
                                fontSize: 15,
                                fontFamily: 'Inter'))
                        : Text(widget.result,
                            style: TextStyle(
                                color: Color.fromARGB(255, 235, 51, 38),
                                fontSize: 15,
                                fontFamily: 'Inter'))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Inter',
                        // The color must be set to white for the gradient to show
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image(image: AssetImage('Images/fake_image.png'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _guageIndicator(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          axisLabelStyle: GaugeTextStyle(color: whiteColor),
          minimum: 0,
          maximum: 110,
          interval: 10,
          ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 33.3, color: Colors.red),
            GaugeRange(startValue: 33.3, endValue: 66.6, color: Colors.orange),
            GaugeRange(startValue: 66.6, endValue: 100, color: Colors.green),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: double.parse(widget.confidence),
              needleColor: whiteColor,
              enableAnimation: true,
              needleStartWidth: 1,
              needleEndWidth: 8,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  widget.confidence,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    color: whiteColor,
                  ),
                ),
              ),
              angle: 85,
              positionFactor: 0.8,
            ),
          ],
        ),
      ],
    );
  }
}
