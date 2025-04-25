import 'package:flutter/material.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  List<String>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromLocalDB();
  }

  Future<void> fetchDataFromLocalDB() async {
    await Future.delayed(Duration(seconds: 2)); // simulate delay

    // Simulated data as if fetched from a local database
    List<String> fetchedData = [
      'User 1: Khizer',
      'User 2: Haider',
      'User 3: Ali',
      'User 4: Sarah',
      'User 5: Ahmed',
    ];

    setState(() {
      data = fetchedData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Simulated DB Query'),
      ),
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Card(child: ListTile(title: Text(data![index])));
                  },
                ),
      ),
    );
  }
}
