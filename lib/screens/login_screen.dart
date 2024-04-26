import 'package:fake_vision/resources/auth_methods.dart';
import 'package:fake_vision/responsive/mobile_screen_layout.dart';
import 'package:fake_vision/responsive/responsive_layout_screen.dart';
import 'package:fake_vision/responsive/web_screen_layout.dart';
import 'package:fake_vision/screens/forgot_password_screen.dart';
import 'package:fake_vision/screens/sign_up_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//stateful widget is mutable based on user's interaction
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
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
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == 'success') {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              ),
            ),
            (route) => false);
      }

      setState(() {
        _isLoading = false;
      });
    } else if (res == 'Please fill all the fields!!') {
      showSnackBar(context, res);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

//The BuildContext show where a specific widget is positioned within tree.
  @override
  Widget build(BuildContext context) {
    //scaffold is useful widget that is used to create basic app structure
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //screen will not resize when keyboard appears
      // SafeArea ensures that the Scaffold doesn't overlap with the top status bar or the bottom navigation area on devices
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
          //This line of code is used to dynamically set the padding of a widget in Flutter based on the width of the device's screen.
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 42),
          //full width of device
          width: double.infinity,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 97,
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [blue, green],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: Text(
                      'Welcome to FakeVision',
                      style: TextStyle(
                        fontSize: 23.0,
                        fontFamily: 'Inter',
                        // The color must be set to white for the gradient to show
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text('Enter your Credentials',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          color: whiteColor)),
                ],
              ),

              const SizedBox(
                height: 87,
              ),

              //Text field input for email
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: whiteColor,
                ),
                child: TextFieldInput(
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //Text field input for password
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: whiteColor,
                ),
                child: TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 161.0),
                //GestureDetector is a widget in Flutter used to detect and respond to gestures made by the user.
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  ),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: blue,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              //button login
              InkWell(
                onTap: loginUser,
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
                      ? const Text('Log in',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              color: whiteColor))
                      : const CircularProgressIndicator(
                          color: whiteColor,
                        ),
                ),
              ),
              SizedBox(
                height: 12,
              ),

              SizedBox(
                height: 12,
              ),
              //google icon

              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              //transitioning to signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: whiteColor, fontFamily: 'Inter', fontSize: 12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blue,
                            fontFamily: 'Inter',
                            fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
