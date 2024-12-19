import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Center(
          child: Text(
            "Edit Profile",
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
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nama Anda',
                      labelStyle: FontCollections.paragraph2,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Pekerjaan',
                      labelStyle: FontCollections.paragraph2,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorCollections.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        ),
                        child: Text(
                          'Simpan',
                          style: FontCollections.paragraph1
                              .copyWith(color: ColorCollections.colorWhite),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        ),
                        child: Text(
                          'Batal',
                          style: FontCollections.paragraph1
                              .copyWith(color: ColorCollections.colorWhite),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
