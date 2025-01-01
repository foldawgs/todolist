import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/pages/editcatatanPages.dart';

class DetailCatatanPage extends StatefulWidget {
  final DocumentReference reference;
  final String name;
  final String description;
  final String date;
  final String time;
  final String category;
  final String reminder;

  const DetailCatatanPage({
    Key? key,
    required this.reference,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.reminder,
  }) : super(key: key);

  @override
  _DetailCatatanPageState createState() => _DetailCatatanPageState();
}

class _DetailCatatanPageState extends State<DetailCatatanPage> {
  late String _reminder; // Menyimpan state untuk reminder

  @override
  void initState() {
    super.initState();
    _reminder = widget.reminder; // Inisialisasi dari data awal
  }

  Future<void> _updateReminder(String newValue) async {
    setState(() {
      _reminder = newValue; // Perbarui state lokal
    });

    try {
      // Simpan ke Firestore
      await widget.reference.update({'reminder': newValue});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupdate pengingat: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        elevation: 0,
        title: Text(
          "Detail Catatan",
          style: FontCollections.h3,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              widget.name,
              style: FontCollections.h2,
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: FontCollections.paragraph2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  "Tanggal & Waktu",
                  style: FontCollections.paragraph1,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.date}, ${widget.time}",
              style: FontCollections.paragraph2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.notifications, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  "Ingatkan saya",
                  style: FontCollections.paragraph1,
                ),
              ],
            ),
            const SizedBox(height: 4),
            DropdownButton<String>(
              isExpanded: true,
              value: _reminder,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _updateReminder(newValue); // Perbarui nilai reminder
                }
              },
              items: [
                '10 menit sebelumnya',
                '15 menit sebelumnya',
                '30 menit sebelumnya',
                '40 menit sebelumnya',
                '60 menit sebelumnya',
                '120 menit sebelumnya',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCatatanPage(
                            reference: widget.reference,
                            name: widget.name,
                            description: widget.description,
                            date: widget.date,
                            time: widget.time,
                            category: widget.category,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
