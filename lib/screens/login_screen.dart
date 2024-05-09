// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/screens/signup_screen.dart';
import 'package:tinhtoandidong_project/screens/welcom.dart';
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
  @override
  void dispose() {
    // TODO: implement dispose
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
            //todo: title

            //todo:field email
            const SizedBox(height: 10),
            TextFieldInput(
              onChanged: (value) => _checkIfFilled(),
              textEditingController: _emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              fillColor: Colors.red.shade400,
            ),
            //todo: field password
            const SizedBox(height: 16),
            TextFieldInput(
                onChanged: (value) => _checkIfFilled(),
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.visiblePassword,
                fillColor: Colors.red.shade400,
                isPass: true),

            //todo: button login
            const SizedBox(height: 16),
            InkWell(
              onTap: _isFilled
                  ? () async {
                      String res = await AuthMethods().signInUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      print(res);
                      if (res == "Success dang nhap:o auth_method.dart") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const WelcomeScreen();
                        }));
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
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red.shade900,
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
                    'Don\'t have an account?',
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
                        return const SignupScreen();
                      }));
                    },
                    child: Text('Sign up',
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
  }
}
