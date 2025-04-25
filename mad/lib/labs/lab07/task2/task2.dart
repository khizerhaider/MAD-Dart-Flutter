import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class FetchPostScreen extends StatefulWidget {
  const FetchPostScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FetchPostScreenState createState() => _FetchPostScreenState();
}

class _FetchPostScreenState extends State<FetchPostScreen> {
  Map<String, dynamic>? post;
  bool isLoading = false;

  Future<void> fetchRandomPost() async {
    setState(() {
      isLoading = true;
      post = null;
    });

    int postId = Random().nextInt(100) + 1;
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          post = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomPost(); // Automatically fetch on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Post')),
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : post == null
                ? Text('No data')
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        post!['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(post!['body']),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: fetchRandomPost,
                        child: Text('Fetch Another Post'),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
