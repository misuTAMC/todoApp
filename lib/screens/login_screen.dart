// ignore_for_file: avoid_print
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/responsive/responsive_layout_screen.dart';
import 'package:tinhtoandidong_project/responsive/web_screen.layout.dart';
import 'package:tinhtoandidong_project/screens/signup_screen.dart';
import 'package:tinhtoandidong_project/screens/todo_screen.dart';
import 'package:tinhtoandidong_project/utils/utils.dart';
import 'package:tinhtoandidong_project/widgets/logo_app.dart';
import 'package:tinhtoandidong_project/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isFilled = false;
  bool _isLoading = false;
  double opacityValue = 1.0;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkIfFilled() {
    setState(() {
      _isFilled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    print(res);
    if (res == "Success dang nhap:o auth_method.dart") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: TodoScreen(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
      print("loi dang nhap: $res");
    }
    setState(() {
      _isLoading = false;
    });
  }

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      200 + Random().nextInt(56), // Red value will be between 200 and 255
      200 + Random().nextInt(56), // Green value will be between 200 and 255
      200 + Random().nextInt(56), // Blue value will be between 200 and 255
    );
  }

  void navigatorToSignup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SignupScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 600,
            left: 200,
            child: AnimatedOpacity(
              opacity: opacityValue,
              duration: const Duration(seconds: 2),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Transform.rotate(
                  angle: 0.2,
                  child: Container(
                    width: 300,
                    height: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                      color: getRandomColor(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(-5, 0),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Today is a new day!',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!.',
                            maxLines: 16,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 50,
            child: AnimatedOpacity(
              opacity: opacityValue,
              duration: const Duration(seconds: 4),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Transform.rotate(
                  angle: -0.1,
                  child: Container(
                    width: 300,
                    height: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                      color: getRandomColor(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(-5, 0),
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '#TODO: Add some tasks',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!.',
                            maxLines: 15,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 200),
                  // Logo
                  const LogoApp(),
                  const SizedBox(height: 20),
                  // Email TextField
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  // Password TextField
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.visiblePassword,
                    fillColor: Colors.white,
                    isPass: true,
                  ),
                  const SizedBox(height: 16),
                  // Login Button
                  InkWell(
                    onTap: _isFilled ? loginUser : null,
                    child: AnimatedOpacity(
                      opacity: _isFilled ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          color: Color.fromARGB(163, 24, 24, 0),
                        ),
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Log in',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 320),
                  // Sign Up Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Don\'t have an account yet?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: navigatorToSignup,
                          child: const Text(
                            ' Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
