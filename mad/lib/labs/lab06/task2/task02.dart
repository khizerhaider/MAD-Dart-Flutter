import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Card'), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: 350, //set the width of the card
          height: 500, //set the height of the card
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //banner and avatar stack
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    //banner at the top
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          child: Image.asset(
                            '/images/background.png', //your banner image
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 40), //space for the avatar overflow
                      ],
                    ),

                    //avatar overlapping the banner
                    Positioned(
                      top: 50, //position to overlap with banner bottom
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('/images/profile.png'),
                      ),
                    ),
                  ],
                ),

                //name
                Text(
                  'Syed Muhammad Khizer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                //bio
                Text(
                  'Software Engineer | NUST | Web Engineer',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                //action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                      ),
                      child: Text('Follow'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                      ),
                      child: Text('Message'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
