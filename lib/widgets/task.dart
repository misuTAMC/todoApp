import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/model/note.dart';
import 'package:tinhtoandidong_project/screens/edit_note_screen.dart';

class TaskForm extends StatefulWidget {
  final Note _note;

  const TaskForm(this._note, {super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool isDone = false;
  double opacityValue = 1.0;

  Color getRandomColor() {
    return Color.fromARGB(
      255,
      128 + Random().nextInt(120), // Red value will be between 128 and 255
      128 + Random().nextInt(120), // Green value will be between 128 và 255
      128 + Random().nextInt(120), // Blue value will be between 128 và 255
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const EditNote(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, -1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration:
                const Duration(seconds: 2), // Thời gian hiệu ứng là 2 giây
          ),
        );
      },
      child: AnimatedOpacity(
        opacity: opacityValue,
        duration: const Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Transform.rotate(
            angle: -0.05,
            child: Container(
              width: 220,

              margin: const EdgeInsets.only(bottom: 10), // Adjust margin here
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
                image: DecorationImage(
                  image:
                      AssetImage('assets/taskPicture/${widget._note.type}.png'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '#${widget._note.title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(color: Colors.black),
                          checkColor: Colors.green,
                          activeColor: Colors.black,
                          fillColor: MaterialStateProperty.all(Colors.white),
                          value: isDone,
                          onChanged: (value) {
                            setState(
                              () {
                                isDone = !isDone;
                                opacityValue = isDone ? 0.0 : 1.0;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget._note.subTitle,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // Expanded(
                    //   child: Image(
                    //     image: AssetImage(
                    //         'assets/taskPicture/${widget._note.type}.png'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
