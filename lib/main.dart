import 'package:flutter/material.dart';
import 'recording_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recording App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecordingScreen(),
    );
  }
}
