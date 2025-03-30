// lib/labs/lab05/task1/screen.dart
import 'package:flutter/material.dart';

class Task1Screen extends StatefulWidget {
  const Task1Screen({super.key});

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  // Variables to control animations
  double _containerWidth = 100;
  double _containerHeight = 100;
  Color _containerColor = Colors.blue;
  double _borderRadius = 8;
  bool _showText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1: Implicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedContainer example
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _containerWidth,
              height: _containerHeight,
              decoration: BoxDecoration(
                color: _containerColor,
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
            ),
            const SizedBox(height: 20),
            // Button to change container properties
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Toggle between two sets of properties
                  _containerWidth = _containerWidth == 100 ? 200 : 100;
                  _containerHeight = _containerHeight == 100 ? 150 : 100;
                  _containerColor = _containerColor == Colors.blue
                      ? Colors.green
                      : Colors.blue;
                  _borderRadius = _borderRadius == 8 ? 30 : 8;
                });
              },
              child: const Text('Animate Container'),
            ),
            const SizedBox(height: 40),
            // AnimatedOpacity example
            AnimatedOpacity(
              opacity: _showText ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: const Text(
                'This text fades in and out',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            // Button to toggle text visibility
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showText = !_showText;
                });
              },
              child: Text(_showText ? 'Hide Text' : 'Show Text'),
            ),
          ],
        ),
      ),
    );
  }
}
