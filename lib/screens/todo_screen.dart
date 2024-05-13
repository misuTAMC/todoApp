import 'package:flutter/material.dart';
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
      backgroundColor: Colors.purple.shade100,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.pink.shade300,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const TaskForm();
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
