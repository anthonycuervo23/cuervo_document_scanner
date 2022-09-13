import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cuervo_document_scanner/cuervo_document_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin Example app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cuervo Document Scanner Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _pictures = [];

  void onPressed(Source source) async {
    List<String> pictures;
    try {
      // Call the method to get pictures from selected source
      pictures = await CuervoDocumentScanner.getPictures(source) ?? [];
      if (!mounted) return;
      setState(() {
        // Update the pictures list
        _pictures = pictures;
      });
    } catch (e) {
      // Handle exception here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                // Button to get pictures from gallery
                ElevatedButton.icon(
                  onPressed: () => onPressed(Source.GALLERY),
                  icon: const Icon(Icons.photo_size_select_actual_rounded),
                  label: const Text("Gallery"),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                // Button to get pictures from camera
                ElevatedButton.icon(
                  onPressed: () => onPressed(Source.CAMERA),
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera"),
                ),
              ],
            ),
            // Display cropped pictures
            for (var picture in _pictures) Image.file(File(picture)),
          ],
        ),
      ),
    );
  }
}
