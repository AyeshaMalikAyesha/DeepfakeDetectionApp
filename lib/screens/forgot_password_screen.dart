import 'package:fake_vision/screens/login_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
    _confirmPasswordController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/bg16.png'), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(0),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(20, 37, 83, 1), // light blue
                  Color.fromARGB(255, 22, 54, 70) // dark blue
                ]),
          ),
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 42),
          //full width of device
          width: double.infinity,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 80),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [blue, green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Coniferous',
                    // The color must be set to white for the gradient to show
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                height: 94,
              ),

              //Text field input for password
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: whiteColor,
                ),
                child: PasswordInput(hintText: "Enter New Password"),
              ),
              const SizedBox(
                height: 24,
              ),

              //Text field input for confirm password
              Container(
                child: PasswordInput(hintText: "Confirm Password"),
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 24,
              ),
              //button login
              InkWell(
                onTap: () {},
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
                      ? const Text('Change Password',
                          style: TextStyle(
                              fontSize: 14,
                              color: whiteColor,
                              fontFamily: 'Inter'))
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
