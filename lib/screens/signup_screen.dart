// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/screens/login_screen.dart';
import 'package:tinhtoandidong_project/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isFilled = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            const Image(
              alignment: Alignment.center,
              image: AssetImage('assets/logos/crafty-red-cherry-tomato.png'),
              width: 100,
              height: 100,
            ),
            //todo:field username
            const SizedBox(height: 10),
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
                fillColor: const Color.fromARGB(163, 24, 24, 0)),
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
            GestureDetector(
              onTap: _isFilled
                  ? () async {
                      String res = await AuthMethods().signUpUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                        phone: _phoneController.text,
                      );
                      print(res);
                      if (res == 'Success dang ki:o auth_method.dart') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    }
                  : null,
              child: AnimatedOpacity(
                opacity: _isFilled ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  width: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: Color.fromARGB(163, 24, 24, 0),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown.shade900,
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
                    'Have an account?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown.shade900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Sign up',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.brown.shade900,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
