import 'package:flutter/material.dart';

class pageNotifikasi extends StatelessWidget {
  const pageNotifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.pop(context);
            },
        ),
      ),
      body: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: Colors.blue[100],
          child: Text('Notification 1'),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: Colors.blue[200],
          child: Text('Notification 2'),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: Colors.blue[300],
          child: Text('Notification 3'),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          color: Colors.blue[400],
          child: Text('Notification 4'),
        ),
      ],
    ),
    );
  }
}
