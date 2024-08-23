import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'saved_recordings_screen.dart';

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    if (await Permission.microphone.isGranted) {
      try {
        await _recorder.openRecorder();
      } catch (e) {
        // Handle initialization error
        print('Error initializing recorder: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing recorder.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Microphone permission is required.')),
      );
    }
  }

  Future<void> _startRecording() async {
    try {
      if (!_isRecording) {
        await _recorder.startRecorder(toFile: 'audio.aac');
        setState(() {
          _isRecording = true;
          _isPaused = false;
        });
      } else if (_isPaused) {
        await _recorder.resumeRecorder();
        setState(() {
          _isPaused = false;
        });
      } else {
        await _recorder.pauseRecorder();
        setState(() {
          _isPaused = true;
        });
      }
    } catch (e) {
      print('Error starting/stopping recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting/stopping recording.')),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      if (_isRecording) {
        await _recorder.stopRecorder();
        setState(() {
          _isRecording = false;
          _isPaused = false;
        });
      }
    } catch (e) {
      print('Error stopping recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error stopping recording.')),
      );
    }
  }

  Future<void> _cancelRecording() async {
    try {
      if (_isRecording) {
        await _recorder.stopRecorder();
        setState(() {
          _isRecording = false;
          _isPaused = false;
        });
        // Optionally, delete the file here
      }
    } catch (e) {
      print('Error canceling recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error canceling recording.')),
      );
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recording Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the Recording App'),
            SizedBox(height: 20),
            Text(_isRecording ? (_isPaused ? 'Paused' : 'Recording...') : 'Press Record to start'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel Button
                IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.red,
                  onPressed: _cancelRecording,
                ),
                // Record / Pause Button
                IconButton(
                  icon: Icon(_isRecording ? (_isPaused ? Icons.play_arrow : Icons.pause) : Icons.mic),
                  color: Colors.blue,
                  onPressed: _startRecording,
                ),
                // Save Button
                IconButton(
                  icon: Icon(Icons.save),
                  color: Colors.green,
                  onPressed: !_isRecording ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavedRecordingsScreen()),
                    );
                  } : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
