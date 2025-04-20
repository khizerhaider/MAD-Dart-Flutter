// lib/labs/lab05/task3/screen.dart
import 'package:flutter/material.dart';
import 'screen2.dart';

class Task3FirstScreen extends StatelessWidget {
  const Task3FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 3: Hero Animation - Screen 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Click on the image to see Hero animation'),
            const SizedBox(height: 20),
            Hero(
              tag: 'imageHero',
              child: Image.network('https://picsum.photos/200', width: 200),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Task3SecondScreen(),
                  ),
                );
              },
              child: const Text('View Image Details'),
            ),
          ],
        ),
      ),
    );
  }
}
