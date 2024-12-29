import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/auth.dart';
import 'package:todolist/pages/signInPage.dart';
import 'package:todolist/pages/editProfilePage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, String>> getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return {
        'name': userData['username'] ?? 'User',
        'job': userData['job'] ?? 'Pekerjaan tidak diketahui',
      };
    }
    return {
      'name': 'User',
      'job': 'Pekerjaan tidak diketahui',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Center(
          child: Text(
            "Profile",
            style: FontCollections.h2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, String>>(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final userInfo = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 82,
                    child: Icon(Icons.person, size: 82),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "${userInfo['name']} | ${userInfo['job']}",
                    style: FontCollections.paragraph1,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCollections.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: FontCollections.paragraph1
                          .copyWith(color: ColorCollections.colorWhite),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await Auth().signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    ),
                    child: Text(
                      'Logout',
                      style: FontCollections.paragraph1
                          .copyWith(color: ColorCollections.colorWhite),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView(
                      children: [
                        buildInfoCard(
                          context,
                          icon: Icons.list,
                          label: "25 Catatan",
                        ),
                        SizedBox(height: 20),
                        buildInfoCard(
                          context,
                          icon: Icons.mic,
                          label: "5 Catatan Suara",
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildInfoCard(BuildContext context, {required IconData icon, required String label}) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Icon(icon, color: ColorCollections.primaryBlue),
          SizedBox(width: 20),
          Text(
            label,
            style: FontCollections.paragraph2,
          ),
        ],
      ),
      height: 100,
      decoration: BoxDecoration(
        color: ColorCollections.colorWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
