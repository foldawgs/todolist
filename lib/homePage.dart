import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/notifikasi.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/profile_pic.jpg'), // Replace with your profile picture asset
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello!',
              style: FontCollections.h4, // Smaller font size for 'Hello!'
            ),
            Text(
              'User!',
              style: FontCollections.h2, // Smaller font size for 'User!'
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageNotifikasi()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
          ),
          Container(
            width: 350,
            height: 150,
            color: ColorCollections.primaryBlue,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Text('Deadline 1')),
                ),
                Container(
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Text('Deadline 1')),
                ),
                Container(
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Text('Deadline 1')),
                ),
                Container(
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Text('Deadline 1')),
                ),
                Container(
                  width: 100,
                  color: Colors.green,
                  child: Center(child: Text('Deadline 2')),
                ),
                Container(
                  width: 100,
                  color: Colors.blue,
                  child: Center(child: Text('Deadline 3')),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.yellow,
                  child: Center(child: Text('Kategori Catatan 1')),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.orange,
                  child: Center(child: Text('Kategori Catatan 2')),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.purple,
                  child: Center(child: Text('Kategori Catatan 3')),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.teal,
                  child: Center(child: Text('Kategori Catatan 4')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
