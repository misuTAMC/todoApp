import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tinhtoandidong_project/provider/time_provider.dart';
import 'package:tinhtoandidong_project/screens/todo_screen.dart';
import 'package:tinhtoandidong_project/widgets/time_options.dart';

// Tạo class PomodoroScreen kế thừa StatefulWidget
class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

// Định nghĩa state cho PomodoroScreen
class _PomodoroScreenState extends State<PomodoroScreen> {
  @override
  Widget build(BuildContext context) {
    final providerControlTime =
        Provider.of<TimeProvider>(context); // Lấy provider
    final seconds = providerControlTime.currentDuration % 60; // Tính giây
    final minutes = providerControlTime.currentDuration ~/ 60; // Tính phút
    if (providerControlTime.selectedTime == 0) {
      return Scaffold(
        body: Center(
          child: Text(
              'Please set a timer duration'), // Hiển thị nếu chưa đặt thời gian
        ),
      );
    }
    if (providerControlTime.currentDuration == 0 &&
        providerControlTime.timePlaying == false) {
      providerControlTime.currentDuration =
          providerControlTime.selectedTime; // Đặt lại thời gian hiện tại
      WidgetsBinding.instance.addPostFrameCallback(
        // callback sau khi frame được render
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
    // Main screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // chứa nền và ảnh động
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 190, 230, 247),
          image: DecorationImage(
            image: providerControlTime.currentDuration >
                    providerControlTime.selectedTime / 2
                ? AssetImage('assets/logos/sunback.jpg')
                : AssetImage('assets/logos/moonback.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // tạo nút quay lại
        child: SingleChildScrollView(
          // cho phép cuộn
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
                        // khi pressed
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  const TodoScreen(), // quay lại màn hình TodoScreen
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
              // Pikachu screen
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
              // Bộ đếm thời gian
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // căn giữa
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.6, //thiết lập chiều rộng container = 60% màn hình.
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20), // bo tròn các gốc
                      boxShadow: [
                        // thêm bóng đổ để tạo hiệu ứng nổi
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // màu bóng mờ là 50%
                          spreadRadius: 5, // độ lan
                          blurRadius: 7, // độ mờ
                          offset: Offset(0, 3), // độ xê dịch của bóng
                        ),
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          // tạo đường viền
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // hiển thị thời gian
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
              //Ảnh động thay đổi theo thời gian
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.width *
                    (1 -
                        providerControlTime.currentDuration /
                            providerControlTime.selectedTime),
                child: Image(
                  image: providerControlTime.currentDuration <=
                          providerControlTime.selectedTime / 2
                      ? AssetImage('assets/logos/moon.gif')
                      : AssetImage('assets/logos/sun.gif'),
                ),
              ),
              const SizedBox(height: 20),
              //Hiển thị thanh tiến trình
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Stack(
                  // cho phép chồng các widget con lên nhau
                  children: [
                    Container(
                      decoration: BoxDecoration(),
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
                            backgroundColor: Colors.transparent,
                            progressColor: Colors.transparent,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 40, // Điều chỉnh giá trị này theo nhu cầu
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
                      top: 100, // Điều chỉnh giá trị này theo nhu cầu
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
                      top: -12, // Điều chỉnh giá trị này theo nhu cầu
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
              // Hiển thị các widget
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

// Định nghĩa class TimeController kế thừa StatelessWidget
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
              Provider.of<TimeProvider>(context, listen: false)
                  .pauseTimer(); // Tạm dừng thời gian
            } else {
              Provider.of<TimeProvider>(context, listen: false)
                  .startTimer(); // Bắt đầu thời gian
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
