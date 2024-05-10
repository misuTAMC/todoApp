import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Image(
          alignment: Alignment.center,
          image: AssetImage('assets/logos/crafty-red-cherry-tomato.png'),
          width: 100,
          height: 100,
        ),
        Positioned(
          top: 50,
          left: 50,
          child: Image(
            alignment: Alignment.center,
            image: AssetImage('assets/logos/crafty-pink-round-confetti-1.png'),
            width: 50,
            height: 50,
          ),
        ),
        Positioned(
          top: 70,
          left: 40,
          child: Image(
            alignment: Alignment.center,
            image: AssetImage('assets/logos/crafty-red-round-confetti-1.png'),
            width: 30,
            height: 30,
          ),
        ),
        Positioned(
          top: 75,
          left: 60,
          child: Image(
            alignment: Alignment.center,
            image: AssetImage('assets/logos/crafty-yellow-round-confetti.png'),
            width: 25,
            height: 25,
          ),
        ),
        Positioned(
          top: 65,
          left: 55,
          child: Image(
            alignment: Alignment.center,
            image: AssetImage('assets/logos/scandi-364.png'),
            width: 20,
            height: 20,
          ),
        )
      ],
    );
  }
}
