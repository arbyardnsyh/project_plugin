import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img; // Import pustaka image
import 'displaypicture_screen.dart';
import 'filter_carousel.dart';

class TakepictureScreen extends StatefulWidget {
  const TakepictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakepictureScreenState createState() => TakepictureScreenState();
}

class TakepictureScreenState extends State<TakepictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Uint8List? _imageBytes;
  final ValueNotifier<Color> _selectedFilterColor = ValueNotifier<Color>(Colors.transparent);

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _selectedFilterColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera by: arby.ardnsyh_ (NIM:362358302150) ')),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Menampilkan pratinjau kamera dengan filter yang diterapkan
                return ValueListenableBuilder<Color>(
                  valueListenable: _selectedFilterColor,
                  builder: (context, color, child) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(color, BlendMode.color),
                      child: CameraPreview(_controller),
                    );
                  },
                );
              } else {  
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Menampilkan carousel filter di bagian bawah layar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PhotoFilterCarousel(
              onFilterChanged: (color) {
                _selectedFilterColor.value = color; // Mengubah filter sesuai pilihan
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            final bytes = await image.readAsBytes();

            // Load gambar menggunakan pustaka `image`
            img.Image originalImage = img.decodeImage(bytes)!;

            // Terapkan filter warna pada gambar yang diambil
            final filterColor = _selectedFilterColor.value;
            final r = filterColor.red;
            final g = filterColor.green;
            final b = filterColor.blue;
            final opacity = filterColor.opacity; // Ambil opasitas filter

            for (int y = 0; y < originalImage.height; y++) {
              for (int x = 0; x < originalImage.width; x++) {
                int pixel = originalImage.getPixel(x, y);
                int pixelR = img.getRed(pixel);
                int pixelG = img.getGreen(pixel);
                int pixelB = img.getBlue(pixel);

                // Campurkan warna filter dengan warna piksel asli, sesuai opasitas
                int newR = ((1 - opacity) * pixelR + opacity * r).round();
                int newG = ((1 - opacity) * pixelG + opacity * g).round();
                int newB = ((1 - opacity) * pixelB + opacity * b).round();

                originalImage.setPixel(x, y, img.getColor(newR, newG, newB));
              }
            }

            // Konversi kembali gambar dengan filter menjadi byte data
            Uint8List filteredBytes = Uint8List.fromList(img.encodeJpg(originalImage));

            // Navigasi ke halaman DisplayPictureScreen dengan gambar yang sudah difilter
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imageBytes: filteredBytes),
              ),
            );
          } catch (e) {
            print('Error mengambil gambar: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal mengambil gambar: $e')),
            );
          }
        },
        child: const Icon(Icons.camera_alt),
      ),


    );
  }
}
