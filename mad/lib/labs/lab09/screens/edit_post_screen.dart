import 'package:flutter/material.dart';
import '../../../../services/api_service.dart';
import '../../../../models/post.dart';

class EditPostScreen extends StatefulWidget {
  final Post post;
  const EditPostScreen({super.key, required this.post});

  @override
  // ignore: library_private_types_in_public_api
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String body;

  @override
  void initState() {
    super.initState();
    title = widget.post.title;
    body = widget.post.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: "Title"),
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                initialValue: body,
                decoration: InputDecoration(labelText: "Body"),
                onSaved: (value) => body = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();
                  await ApiService().updatePost(widget.post.id, title, body);
                  Navigator.pop(
                    context,
                    Post(id: widget.post.id, title: title, body: body),
                  );
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
