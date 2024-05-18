import 'package:flutter/material.dart';

class ImageSelectionScreen extends StatefulWidget {
  final List<String> images;

  ImageSelectionScreen({required this.images});

  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select a background image',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: widget.images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // adjust to fit your needs
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, widget.images[index]);
            },
            child: Image.asset(
                widget.images[index]), // replace with your image widget
          );
        },
      ),
    );
  }
}
