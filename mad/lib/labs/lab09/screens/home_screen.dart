import 'package:flutter/material.dart';
import '../../../../../../services/api_service.dart';
import '../../../../models/post.dart';
import 'create_post_screen.dart';
import 'edit_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts();
  }

  void refresh() {
    setState(() {
      futurePosts = ApiService().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No posts available."));
          }
          return ListView(
            children:
                snapshot.data!.map((post) {
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            final updatedPost = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditPostScreen(post: post),
                              ),
                            );

                            if (updatedPost != null && mounted) {
                              setState(() {
                                final index = snapshot.data!.indexWhere(
                                  (p) => p.id == post.id,
                                );
                                if (index != -1) {
                                  snapshot.data![index] = updatedPost;
                                }
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await ApiService().deletePost(post.id);
                            refresh();
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePostScreen()),
          );
          refresh();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
