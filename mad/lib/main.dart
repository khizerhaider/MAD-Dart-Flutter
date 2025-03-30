import 'package:flutter/material.dart';
import 'labs/lab03/khizer.dart' as lab03;
import 'labs/lab03/task1.dart' as lab03;
import 'labs/lab05/lab05.dart' as lab05;

void main() {
  runApp(const LabApp());
}

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Labs',
      theme: ThemeData(primarySwatch: Colors.blue),
      // un comment the Task you want to run
      // but be careful that only 1 task will be executed at a time
      home: const lab05.Task1Screen(),
      //home: const lab05.Task2Screen(),
      //home: const lab05.Task3FirstScreen(),
      //home: const lab05.Task3SecondScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Labs')),
      body: ListView(
        children: [
          // Lab 3 Section - Updated to match your actual class names
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lab 03',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Design Screen'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const lab03.Design()),
              );
            },
          ),
          ListTile(
            title: const Text('My Home Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const lab03.MyHomePage(title: 'Task 1'),
                ),
              );
            },
          ),

          // Lab 5 Section (unchanged)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lab 05 - Animations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Task 1: Implicit Animations'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const lab05.Task1Screen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Task 2: Explicit Animations'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const lab05.Task2Screen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Task 3: Hero Animation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const lab05.Task3FirstScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
