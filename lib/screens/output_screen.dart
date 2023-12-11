import 'package:fake_vision/screens/main_app_screen.dart';
import 'package:fake_vision/utils/app_export.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});
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
                              style: theme.textTheme.bodyMedium,
                            )
                          : const CircularProgressIndicator(
                              color: primaryColor,
                            ),
                    ),
                  ),
                ],
              ),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [blue, green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  'Model Results',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Coniferous',
                    // The color must be set to white for the gradient to show
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                  height: 180, width: 180, child: _guageIndicator(context)),
              SizedBox(width: 90),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      "Name:",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      "https://youtu.be/cQ54GDm1eL0",
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
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
                        "FakeVision:",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Icon(
                      Icons.error_outline_rounded,
                      color: Color.fromARGB(255, 216, 66, 55),
                    ),
                    Text("Deepfake Detected(85%)",
                        style: TextStyle(
                            color: Color.fromARGB(255, 235, 51, 38),
                            fontSize: 15,
                            fontFamily: 'Inter'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 30),
                      child: Text(
                        "Duration:",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      "72sec",
                      style: theme.textTheme.bodyMedium,
                    )
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
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Coniferous',
                        // The color must be set to white for the gradient to show
                        color: Colors.white,
                      ),
                    ),
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
            GaugeRange(startValue: 0, endValue: 33.3, color: Colors.green),
            GaugeRange(startValue: 33.3, endValue: 66.6, color: Colors.orange),
            GaugeRange(startValue: 66.6, endValue: 110, color: Colors.red),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: 85,
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
                  '85.0',
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'Inter', color: whiteColor),
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
