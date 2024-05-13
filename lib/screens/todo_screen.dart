import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tinhtoandidong_project/screens/add_note_screen.dart';
import 'package:tinhtoandidong_project/widgets/task.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

bool show = true;

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNote(),
              ),
            );
          },
          backgroundColor: Colors.pink.shade300,
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              return const TaskForm();
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
