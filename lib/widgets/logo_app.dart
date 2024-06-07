import 'package:flutter/material.dart';

/*
Định nghĩa lớp LogoApp kế thừa từ StatelessWidget
Constructor của LogoApp, cho phép khởi tạo widget này. 
Từ khóa const cho phép tạo một hằng số của widget nếu các giá trị truyền vào cũng là hằng số.
*/
class LogoApp extends StatelessWidget {
  const LogoApp({
    super.key,
  });

  @override //cho biết phương thức bên dưới ghi đè 1 phương thức trong lớp cha hoặc cơ sở.
  Widget build(BuildContext context) {
    //phương thức build trả về widget giao diện của LogoApp
    return const Stack(
      //Trả về một widget Stack, cho phép xếp chồng các widget con lên nhau.
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
