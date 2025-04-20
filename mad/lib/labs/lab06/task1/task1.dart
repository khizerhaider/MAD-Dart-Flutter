import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  ResponsiveGrid({super.key});
  final List<String> imageUrls = [
    'assets/images/6.png',
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/7.png',
    'assets/images/8.png',
  ];

  @override
  Widget build(BuildContext context) {
    // this gets the current screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = 2; // for default small screens
    if (screenWidth >= 600 && screenWidth < 900) {
      columns = 3; // fir bigger screens
    } else if (screenWidth >= 900) {
      columns = 4; // for more bigger screens
    }
    return Scaffold(
      appBar: AppBar(title: Text('Resturant Menu'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, //dynamic columns relative to screen width,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1, // adjust the ratio of eah cell
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Image.asset(
              imageUrls[index],
              fit: BoxFit.cover, //to cover the whole grid cell
            );
          },
        ),
      ),
    );
  }
}
