// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/constant.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/screens/home_screen.dart';
import 'package:tinhtoandidong_project/utils/utils.dart';
import 'package:tinhtoandidong_project/widgets/logo_app.dart';
import 'package:tinhtoandidong_project/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    _controller.dispose();
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _checkIfFilled() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _isFilled = true;
      });
    } else {
      setState(() {
        _isFilled = false;
      });
    }
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
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   ),
      // );
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return const HomeScreen();
      // }));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
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
                    const LogoApp(),
                    //todo: title

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

                    //todo: button login
                    const SizedBox(height: 16),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
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
                            'If you already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomeScreen();
                              }));
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.pink.shade900,
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
            );
          }),
    );
  }
}
