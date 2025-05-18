import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'upload_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<void> deletePost(String docId, String imageUrl) async {
    await FirebaseFirestore.instance.collection('posts').doc(docId).delete();
    await FirebaseStorage.instance.refFromURL(imageUrl).delete();
  }

  Future<void> downloadImage(String imageUrl) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final response = await HttpClient().getUrl(Uri.parse(imageUrl));
      final bytes = await response.close().then(
        (res) => res.fold<List<int>>([], (a, b) => a..addAll(b)),
      );
      final directory = await getExternalStorageDirectory();
      final file = File(
        '${directory!.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await file.writeAsBytes(bytes);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Image downloaded!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UploadScreen()),
                ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('posts')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, i) {
              final post = posts[i];
              final id = post['id'];
              final title = post['title'];
              final desc = post['description'];
              final imageUrl = post['imageUrl'];

              return Card(
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(desc),
                  leading: GestureDetector(
                    onLongPress: () => downloadImage(imageUrl),
                    child: Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => AlertDialog(
                              title: Text("Delete Post"),
                              content: Text(
                                "Are you sure you want to delete this post?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deletePost(id, imageUrl);
                                    Navigator.pop(ctx);
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
