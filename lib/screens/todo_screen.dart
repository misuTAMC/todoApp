import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';
import 'package:tinhtoandidong_project/screens/add_note_screen.dart';
import 'package:tinhtoandidong_project/widgets/task.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Your Notes',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      wordSpacing: 0.1,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: FloatingActionButton(
                      heroTag: 'addNote',
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
                                    const AddNote(),
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
                        onPressed: () {
                          AuthMethods().signOut(context);
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
    );
  }

  Widget _buildTaskListByType(int type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          type == 0
              ? '  #Study'
              : type == 1
                  ? '  #Healthy'
                  : type == 2
                      ? '  #Work'
                      : type == 3
                          ? '  #Others'
                          : '  #Done',
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

              final taskList = StorageMethod().getTask(snapshot);
              final filteredTasks =
                  taskList.where((task) => task.type == type).toList();

              return Hero(
                tag: 'taskList',
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return Transform.translate(
                      offset: Offset(index * -40.0, 0),
                      child: TaskForm(task),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
