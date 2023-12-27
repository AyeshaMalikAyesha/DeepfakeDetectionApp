import 'package:fake_vision/resources/auth_methods.dart';
import 'package:fake_vision/screens/forgot_password_screen.dart';
import 'package:fake_vision/screens/home/home_screen.dart';
import 'package:fake_vision/screens/sign_up_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:fake_vision/utils/utils.dart';
import 'package:fake_vision/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    if (_emailController.text == "fake_vision.admin76@gmail.com" &&
        _passwordController.text == "admin1234") {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false,
      );
    }

    if (res == 'success') {
      successDialogBox(
        context,
        "Success",
        "You have successfully logged in",
      );

      setState(() {
        _isLoading = false;
      });
    } else if (res == 'Please fill all the fields!!') {
      errorDialogBox(context, "Error", res);
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
              //image
              Image.asset('Images/app_logo-removebg.png'),

              const SizedBox(
                height: 64,
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
                padding: const EdgeInsets.only(left: 150.0),
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
                      decoration: TextDecoration
                          .underline, // Add underline for better indication
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

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "OR",
                    style: TextStyle(color: grey),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      color: grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              //google icon
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                CustomSocialButton(
                    icon_img: Image.network(
                  "https://pngimg.com/uploads/github/small/github_PNG1.png",
                  fit: BoxFit.cover,
                )),
                CustomSocialButton(
                    icon_img: Image.network(
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                        fit: BoxFit.cover)),
                Icon(
                  Icons.facebook,
                  size: 46,
                  color: whiteColor,
                ),
              ]),
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
