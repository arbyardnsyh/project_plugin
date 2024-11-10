import 'package:flutter/material.dart';
import 'dart:typed_data';

class DisplayPictureScreen extends StatelessWidget {
  final Uint8List imageBytes; // Data byte gambar

  const DisplayPictureScreen({Key? key, required this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Galery'),
      ),
      body: Center(
        child: Image.memory(
          imageBytes, // Menampilkan gambar dari byte data
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
