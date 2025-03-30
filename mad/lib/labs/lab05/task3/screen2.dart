// lib/labs/lab05/task3/screen2.dart
import 'package:flutter/material.dart';

class Task3SecondScreen extends StatelessWidget {
  const Task3SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3: Hero Animation - Screen 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'imageHero',
              child: Image.network(
                'https://picsum.photos/200',
                width: 300,
              ),
            ),
            const SizedBox(height: 20),
            const Text('This is the detailed view of the image'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
