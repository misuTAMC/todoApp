import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/provider/time_provider.dart';
import 'package:tinhtoandidong_project/screens/todo_screen.dart';

import 'package:tinhtoandidong_project/widgets/time_options.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  
 

  @override
  Widget build(BuildContext context) {
    final providerControlTime = Provider.of<TimeProvider>(context);
    final seconds = providerControlTime.currentDuration % 60;
    final minutes = providerControlTime.currentDuration ~/ 60;
    if (providerControlTime.selectedTime == 0) {
      return Scaffold(
        body: Center(
          child: Text('Please set a timer duration'),
        ),
      );
    }
    if (providerControlTime.currentDuration == 0 &&
        providerControlTime.timePlaying == false) {
      providerControlTime.currentDuration = providerControlTime.selectedTime;
      AwesomeNotifications().dismissAllNotifications();

      // Tạo thông báo
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'app_notification_channel',
          title: 'Pikachu go',
          body: 'Pika pika!',
          customSound: 'resource://raw/pikachu_sound.wav',
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                actions: <Widget>[
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      AwesomeNotifications().dismissNotificationsByChannelKey(
                        'app_notification_channel',
                      );
                    },
                    child: Image.asset(
                      alignment: Alignment.center,
                      'assets/logos/smile.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Pika pika!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );

     
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 190, 230, 247)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: FloatingActionButton(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const TodoScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  'Pikachu go',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        seconds == 0
                            ? '${minutes}:${seconds.round()}0'
                            : '${minutes}:${seconds.round()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 60,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: Image(
                  image: AssetImage('assets/logos/sun.gif'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 190, 230, 247),
                      ),
                      // This will help visualize the actual width
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return LinearPercentIndicator(
                            animation: true,
                            animateFromLastPercent: true,
                            width: constraints.maxWidth,
                            lineHeight: 30.0,
                            percent: 1 -
                                providerControlTime.currentDuration /
                                    providerControlTime.selectedTime,
                            backgroundColor: Color.fromARGB(255, 190, 230, 247),
                            progressColor: Color.fromARGB(255, 190, 230, 247),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 40, // Adjust this value as needed
                      left: 0,
                      right: 0,
                      child: Divider(
                        color: Color.fromARGB(255, 52, 159, 56),
                        thickness: 10,
                        height: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                    ),
                    Positioned(
                      top: 100, // Adjust this value as needed
                      left: 0,
                      right: 0,
                      child: Divider(
                        color: Colors.brown,
                        thickness: 60,
                        height: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                    ),
                    Positioned(
                      top: -12, // Adjust this value as needed
                      left: MediaQuery.of(context).size.width *
                          (1 -
                              providerControlTime.currentDuration /
                                  providerControlTime.selectedTime),
                      child: Image.asset(
                        'assets/logos/pikachu indicator.gif',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TimeOptions(),
              SizedBox(height: 20),
              TimeController(),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeController extends StatelessWidget {
  const TimeController({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeProvider>(context);
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          onPressed: () {
            if (provider.timePlaying == true) {
              Provider.of<TimeProvider>(context, listen: false).pauseTimer();
            } else {
              Provider.of<TimeProvider>(context, listen: false).startTimer();
            }
            if (provider.currentDuration <= 0) {
              Provider.of<TimeProvider>(context, listen: false).selectTime(
                Provider.of<TimeProvider>(context, listen: false).selectedTime,
              );
            }
          },
          icon: provider.timePlaying
              ? Icon(
                  Icons.pause,
                  size: 40,
                )
              : Icon(
                  Icons.play_arrow,
                  size: 40,
                ),
          color: Colors.black,
        ),
      ),
    );
  }
}
