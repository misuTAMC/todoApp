import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';
import 'package:tinhtoandidong_project/screens/add_note_screen.dart';
import 'package:tinhtoandidong_project/screens/pomodoro_screen.dart';
import 'package:tinhtoandidong_project/widgets/task.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

Color getRandomColor() {
  return Color.fromARGB(
    255,
    200 + Random().nextInt(56), // Red value will be between 200 and 255
    200 + Random().nextInt(56), // Green value will be between 200 and 255
    200 + Random().nextInt(56), // Blue value will be between 200 and 255
  );
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20),
                    //Xây dựng UI dựa trên kết quả của một Future.
                    FutureBuilder<String>(
                      // Chúng ta đang sử dụng phương thức getUserName() là bất đồng bộ, nó trả về một Future mà sẽ hoàn thành sau một khoảng thời gian.
                      future: StorageMethod().getUserName(),
                      // Hàm builder sẽ được gọi để xây dựng UI dựa trên kết quả của Future. Snapshot chứa kết quả của Future.
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        // ConnectionState.waiting nghĩa là Future vẫn chưa hoàn thành, vì vậy chúng ta trả về CircularProgressIndicator để chỉ ra rằng ứng dụng đang chờ.
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        // Nếu Future hoàn thành với một lỗi, dữ liệu không khả dụng, vì vậy chúng ta trả về một thông báo lỗi.
                        else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        // Nếu Future hoàn thành thành công, chúng ta có dữ liệu, vì vậy chúng ta có thể hiển thị nó trong một widget Text.
                        else {
                          return Text(
                            '${snapshot.data}\'s note',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              wordSpacing: 0.1,
                              letterSpacing: 0.1,
                            ),
                          );
                        }
                      },
                    ),

                    const Spacer(),
                    SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: FloatingActionButton(
                        shape: const RoundedRectangleBorder(
                          // hình chữ nhật bo góc
                          side: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const AddNote(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation
                                      .drive(tween), // animation + tween
                                  child: child, // widget con -> addNote
                                );
                              },
                            ),
                          );
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),
                    SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black, // Set border color
                            width: 1.2, // Set border width
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Set color
                              spreadRadius: 2, // Set spread radius
                              blurRadius: 5, // Set blur radius
                              offset: const Offset(-1, 3), // Set offset
                            ),
                          ], // Set border radius
                        ),
                        child: IconButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FutureBuilder<String>(
                                  future: StorageMethod().getUserName(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(); // Show a loading spinner while waiting
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          'Error: ${snapshot.error}'); // Show error message if something went wrong
                                    } else {
                                      return AlertDialog(
                                        // 1 hộp thoại hiện thông báo và in4
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 234, 221, 221),
                                            width: 1,
                                          ),
                                        ),
                                        shadowColor:
                                            Colors.grey.withOpacity(0.6),
                                        backgroundColor: Colors.white,
                                        alignment: Alignment.center,
                                        title: Text(
                                          textAlign: TextAlign.center,
                                          'Sign Out',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        content: Text(
                                          textAlign: TextAlign.center,
                                          'Are you sure you want to sign out?',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),

                                        // Cancel button
                                        actions: <Widget>[
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(getRandomColor()),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              side: WidgetStateProperty.all<
                                                  BorderSide>(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          // Sign out button
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(getRandomColor()),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              side: WidgetStateProperty.all<
                                                  BorderSide>(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Sign Out',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              AuthMethods().signOut(context);
                                            },
                                          ),
                                          // #Pika go button
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(getRandomColor()),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              side: WidgetStateProperty.all<
                                                  BorderSide>(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '#Pika go',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PomodoroScreen(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTaskListByType(0),
                _buildTaskListByType(1),
                _buildTaskListByType(2),
                _buildTaskListByType(3),
                _buildTaskListByType(100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListByType(int type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          type == 0
              ? '  #Study '
              : type == 1
                  ? '  #Healthy '
                  : type == 2
                      ? '  #Work '
                      : type == 3
                          ? '  #Others '
                          : '  #Done ',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
            stream: StorageMethod().streamTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              // neu ko co note, de anh empty
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: type != 100
                      ? const Image(
                          image: AssetImage(
                            'assets/taskPicture/empty.png',
                          ),
                          fit: BoxFit.contain,
                          opacity: AlwaysStoppedAnimation(0.5),
                        )
                      : const SizedBox(),
                );
              }

              final taskList =
                  StorageMethod().getTask(snapshot); //Lấy danh sách từ snapshot
              final filteredTasks = taskList
                  .where((task) => task.type == type)
                  .toList(); // loc danh sach cong viec

              return ListView.builder(
                scrollDirection: Axis.horizontal, // cuộn ngang
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return Transform.translate(
                    offset: Offset(index * -40.0, 0),
                    child: TaskForm(
                        task), // dich chuyển Taskform theo index tạo hiệu ứng trượt
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
