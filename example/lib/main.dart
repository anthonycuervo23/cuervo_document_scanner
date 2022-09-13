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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  var imageAfterCrop = "";

  void _incrementCounter(int i) {
    if (i == 0) {
      CuervoDocumentScanner.getPictures(Source.CAMERA).then((value) => {
            setState(() {
              imageAfterCrop = value?.first ?? "";
            })
          });
    } else {
      CuervoDocumentScanner.getPictures(Source.GALLERY).then((value) => {
            setState(() {
              imageAfterCrop = value?.first ?? "";
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          if (imageAfterCrop.isNotEmpty)
            Image.file(
              File(imageAfterCrop),
              fit: BoxFit.fitWidth,
            )
          else
            Container(),
          Column(
            children: [
              ElevatedButton.icon(
                onPressed: () => _incrementCounter(1),
                icon: const Icon(Icons.photo_size_select_actual_rounded),
                label: const Text("Gallery"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _incrementCounter(0);
                },
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
