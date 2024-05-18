import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinhtoandidong_project/resources/auth_method.dart';
import 'package:tinhtoandidong_project/resources/storage_method.dart';
import 'package:tinhtoandidong_project/screens/add_note_screen.dart';
import 'package:tinhtoandidong_project/screens/choose_background.dart';
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
  List<String> _images = [
    'assets/logos/jelly fish.jpg',
    'assets/logos/owl.jpg',
  ];
  String? _selectedImageFromGallery;
  bool chooseAssetOrImage = false;
  int _currentIndex = 0;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImageFromList() async {
    String? selectedImage = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageSelectionScreen(images: _images)),
    );

    if (selectedImage != null) {
      setState(() {
        _currentIndex = _images.indexOf(selectedImage);
        chooseAssetOrImage = false; // set to false when image is from list
      });
    }
  }

  ImageProvider _getImage() {
    if (chooseAssetOrImage) {
      return FileImage(File(_selectedImageFromGallery!));
    } else {
      return AssetImage(_images[_currentIndex]);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImageFromGallery = image.path;
        chooseAssetOrImage = true; // set to true when image is from gallery
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _getImage(),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20),
                    FutureBuilder<String>(
                      future: StorageMethod().getUserName(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data}\'s note',
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
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        shadowColor:
                                            Colors.grey.withOpacity(0.6),
                                        backgroundColor: getRandomColor(),
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
                                        actions: <Widget>[
                                          TextButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              side: MaterialStateProperty.all<
                                                  BorderSide>(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '#Cancel',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              side: MaterialStateProperty.all<
                                                  BorderSide>(
                                                BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '#Sign Out',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              AuthMethods().signOut(context);
                                            },
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              side: MaterialStateProperty.all<
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
                                                          const PomodoroScreen()));
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.black,
                      icon: Icon(
                        Icons.image_search_sharp,
                      ),
                      onPressed: () async {
                        await _pickImageFromList();
                      },
                    ),
                    IconButton(
                      color: Colors.black,
                      icon: Icon(
                        Icons.add_photo_alternate_outlined,
                      ),
                      onPressed: () async {
                        await _pickImageFromGallery();
                      },
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

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return Transform.translate(
                    offset: Offset(index * -40.0, 0),
                    child: TaskForm(task),
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
