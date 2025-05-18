import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  File? _image;

  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future uploadPost() async {
    if (_image == null) return;

    String postId = Uuid().v4();
    String fileName = "$postId.jpg";

    final ref = FirebaseStorage.instance.ref().child('posts').child(fileName);
    await ref.putFile(_image!);
    final imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('posts').doc(postId).set({
      'id': postId,
      'title': _titleController.text,
      'description': _descController.text,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            _image != null ? Image.file(_image!, height: 150) : Container(),
            ElevatedButton(onPressed: pickImage, child: Text("Pick Image")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: uploadPost, child: Text("Upload")),
          ],
        ),
      ),
    );
  }
}
