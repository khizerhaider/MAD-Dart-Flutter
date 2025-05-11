import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String body = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Body"),
                onSaved: (value) => body = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();
                  await ApiService().createPost(title, body);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, {'title': title, 'body': body});
                },
                child: Text("Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
