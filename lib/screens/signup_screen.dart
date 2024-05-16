import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/responsive/mobile_screen_layout.dart';
import 'package:tinhtoandidong_project/responsive/responsive_layout_screen.dart';
import 'package:tinhtoandidong_project/responsive/web_screen.layout.dart';
import 'package:tinhtoandidong_project/screens/login_screen.dart';
import 'package:tinhtoandidong_project/utils/utils.dart';
import 'package:tinhtoandidong_project/widgets/logo_app.dart';
import 'package:tinhtoandidong_project/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  
  bool _isFilled = false;
  bool _isLoading = false;
  double opacityValue = 1.0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _checkIfFilled() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
  }



  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      phone: _phoneController.text,
    );
    print(res);

    if (res == 'Success dang ki:o auth_method.dart') {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout(),
            ),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  void navigatorToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      200 + Random().nextInt(56), // Red value will be between 200 and 255
      200 + Random().nextInt(56), // Green value will be between 200 and 255
      200 + Random().nextInt(56), // Blue value will be between 200 and 255
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -250,
            left: 150,
            child: AnimatedOpacity(
              opacity: opacityValue,
              duration: const Duration(seconds: 4),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Transform.rotate(
                  angle: -0.5,
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
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!',
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
          Positioned(
            top: -200,
            left: 200,
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
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!',
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
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!',
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
                            'Don\'t read this. It\'s just a dummy text. But if you are reading this, then you are wasting your time. So stop reading this and sign up now!',
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
                children: [
                  const SizedBox(height: 200),
                  const LogoApp(),
                  const SizedBox(height: 20),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _usernameController,
                    hintText: 'Enter your username',
                    textInputType: TextInputType.emailAddress,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.visiblePassword,
                    fillColor: Colors.white,
                    isPass: true,
                  ),
                  const SizedBox(height: 10),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _phoneController,
                    hintText: 'Enter your phone',
                    textInputType: TextInputType.emailAddress,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _isFilled ? signUpUser : null,
                    child: AnimatedOpacity(
                      opacity: _isFilled ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              width: 150,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                color: Color.fromARGB(163, 24, 24, 0),
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 230),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigatorToLogin,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(' Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20), // Add some bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
