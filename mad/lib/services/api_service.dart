import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/post.dart';

class ApiService {
  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> createPost(String title, String body) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
    );
  }

  Future<void> updatePost(int id, String title, String body) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
    );
  }

  Future<void> deletePost(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
