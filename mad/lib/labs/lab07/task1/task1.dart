import 'package:flutter/material.dart';

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Timer App', home: TimerScreen());
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 10;
  bool _isRunning = false;

  void _startTimer() async {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    int remainingSeconds = _seconds; // Use a local variable for the countdown
    while (remainingSeconds > 0) {
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        remainingSeconds--;
        _seconds = remainingSeconds; // Update the UI with the remaining time
      });
    }

    setState(() {
      _isRunning = false;
      _seconds = 10; // Reset timer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer App'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_seconds',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: _startTimer, child: Text('Start Timer')),
          ],
        ),
      ),
    );
  }
}
