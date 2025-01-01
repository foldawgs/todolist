import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/widget/formCatatan.dart';
import 'package:todolist/widget/formSuara.dart';

class TambahCatatan extends StatelessWidget {
  const TambahCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Center(
          child: Text(
            "Tambah Catatan",
            style: FontCollections.h2,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormCatatanPage()),
                );
              },
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.list, color: ColorCollections.primaryBlue),
                    SizedBox(width: 20),
                    Text(
                      "Catatan",
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
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FormSuaraPage()), // Navigasi ke FormSuaraPage
                );
              },
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.mic, color: ColorCollections.primaryBlue),
                    SizedBox(width: 20),
                    Text(
                      "Catatan Suara",
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
            ),
          ],
        ),
      ),
    );
  }
}
