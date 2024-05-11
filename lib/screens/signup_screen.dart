// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinhtoandidong_project/constant.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/responsive/mobile_screen_layout.dart';
import 'package:tinhtoandidong_project/responsive/responsive_layout_screen.dart';
import 'package:tinhtoandidong_project/responsive/web_screen.layout.dart';
import 'package:tinhtoandidong_project/screens/login_screen.dart';
import 'package:tinhtoandidong_project/utils/utils.dart';
import 'package:tinhtoandidong_project/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  //*controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  //*anh,...v
  Uint8List? _image;
  bool _isFilled = false;
  bool _isLoading = false;
  //*animate :>>
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    //*_controller:is the AnimationController that controls the animation
    _controller = AnimationController(
      //*vsync:is the TickerProvider that the AnimationController will use
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _topAlignmentAnimation = setupTopAlignmentAnimation(_controller);
    _bottomAlignmentAnimation = setupBottomAlignmentAnimation(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    //dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
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
      file: _image!,
    );
    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res == 'Success dang ki:o auth_method.dart') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
  }

  void navigatorToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade50,
                  Colors.pink.shade50,
                ],
                begin: _topAlignmentAnimation.value,
                end: _bottomAlignmentAnimation.value,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),
                  //todo: logo
                  // const Image(
                  //   alignment: Alignment.center,
                  //   image: AssetImage('assets/logos/crafty-red-cherry-tomato.png'),
                  //   width: 100,
                  //   height: 100,
                  // ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 55,
                              backgroundImage: MemoryImage(_image!),
                              backgroundColor: Colors.red.shade100,
                            )
                          : CircleAvatar(
                              radius: 55,
                              backgroundImage: const NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
                              backgroundColor: Colors.red.shade100,
                            ),
                      Positioned(
                        bottom: -10,
                        left: 65,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                  //todo:field username
                  const SizedBox(height: 40),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _usernameController,
                    hintText: 'Enter your username',
                    textInputType: TextInputType.emailAddress,
                    fillColor: const Color.fromARGB(163, 24, 24, 0),
                  ),
                  //todo:field email
                  const SizedBox(height: 10),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    fillColor: const Color.fromARGB(163, 24, 24, 0),
                  ),
                  //todo: field password
                  const SizedBox(height: 16),
                  TextFieldInput(
                      onChanged: (value) => _checkIfFilled(),
                      textEditingController: _passwordController,
                      hintText: 'Enter your password',
                      textInputType: TextInputType.visiblePassword,
                      fillColor: const Color.fromARGB(163, 24, 24, 0),
                      isPass: true),
                  //todo:field phone
                  const SizedBox(height: 10),
                  TextFieldInput(
                    onChanged: (value) => _checkIfFilled(),
                    textEditingController: _phoneController,
                    hintText: 'Enter your phone',
                    textInputType: TextInputType.emailAddress,
                    fillColor: const Color.fromARGB(163, 24, 24, 0),
                  ),
                  //todo: button login
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

                  Flexible(
                    flex: 2,
                    child: Container(),
                  ), //todo: button sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigatorToLogin,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(' Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink.shade900,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
