import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_plugin/main.dart';
import 'package:project_plugin/widget/takepicture_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Ambil daftar kamera yang tersedia
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    // Bangun aplikasi dengan kamera pertama
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: TakepictureScreen(camera: firstCamera),
      ),
    );

    // Verifikasi aplikasi terinisialisasi dengan benar
    expect(find.byType(TakepictureScreen), findsOneWidget);
  });
}
