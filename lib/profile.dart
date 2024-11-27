import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            style: FontCollections.h2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 82,
              child: Icon(Icons.person, size: 82),
            ),
            SizedBox(height: 16.0),
            Text(
              "User | Pelajar",
              style: FontCollections.paragraph1,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
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
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.list, color: ColorCollections.primaryBlue),
                        SizedBox(width: 20),
                        Text(
                          "25 Catatan",
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
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.mic, color: ColorCollections.primaryBlue),
                        SizedBox(width: 20),
                        Text(
                          "5 Catatan Suara",
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
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.category, color: ColorCollections.primaryBlue),
                        SizedBox(width: 20),
                        Text(
                          "3 Kategori",
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
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
