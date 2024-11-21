import 'package:flutter/material.dart';

class TambahCatatan extends StatelessWidget {
  const TambahCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Tambah Catatan",
            style: TextStyle(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 350,
              child: Row(
              children: [
                Icon(Icons.list, color: Colors.white),
                SizedBox(width: 10),
                Text(
                "Catatan",
                style: TextStyle(color: Colors.white),
                ),
              ],
              ),
              height: 100,
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20), // Add spacing here
            Container(
              width: 350,
              child: Row(
              children: [
                Icon(Icons.mic, color: Colors.white),
                SizedBox(width: 10),
                Text(
                "Catatan Suara",
                style: TextStyle(color: Colors.white),
                ),
              ],
              ),
              height: 100,
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 20), // Add spacing here
            Container(
              width: 350,
              child: Row(
              children: [
                Icon(Icons.category, color: Colors.white),
                SizedBox(width: 10),
                Text(
                "Kategori",
                style: TextStyle(color: Colors.white),
                ),
              ],
              ),
              height: 100,
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ],
        ),
      ),
    );
  }
}
