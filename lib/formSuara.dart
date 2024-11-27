import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class FormSuaraPage extends StatefulWidget {
  const FormSuaraPage({super.key});

  @override
  _FormSuaraPageState createState() => _FormSuaraPageState();
}

class _FormSuaraPageState extends State<FormSuaraPage> {
  // Controller untuk input text
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  // Variabel untuk dropdown kategori
  String? _selectedKategori;

  // Daftar kategori untuk dropdown
  final List<String> _kategoriList = ['Kategori 1', 'Kategori 2', 'Kategori 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Text(
          "Form Catatan Suara",
          style: FontCollections.h2,
        ),
        centerTitle: true, // Menambahkan ini untuk memastikan title di tengah
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Nama
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Deskripsi
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Suara dengan ikon mic di kanan
            GestureDetector(
              onTap: () {
                // Aksi untuk merekam suara bisa ditambahkan disini
              },
              child: TextField(
                enabled:
                    false, // Nonaktifkan input, hanya untuk tampilkan tombol
                decoration: InputDecoration(
                  labelText: 'Suara',
                  suffixIcon:
                      Icon(Icons.mic, color: ColorCollections.primaryBlue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Dropdown Kategori
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              items: _kategoriList.map((String kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedKategori = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol Simpan
            ElevatedButton(
              onPressed: () {
                // logic
                print('Nama: ${_namaController.text}');
                print('Deskripsi: ${_deskripsiController.text}');
                print('Kategori: $_selectedKategori');

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorCollections.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              ),
              child: Text(
                'Simpan',
                style: FontCollections.paragraph1.copyWith(color: ColorCollections.colorWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
