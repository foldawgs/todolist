import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class FormKategoriPage extends StatefulWidget {
  const FormKategoriPage({super.key});

  @override
  _FormKategoriPageState createState() => _FormKategoriPageState();
}

class _FormKategoriPageState extends State<FormKategoriPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = ['Kategori 1', 'Kategori 2', 'Kategori 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Text(
          "Kategori Baru",
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
                labelText: 'Nama Kategori',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Tombol Simpan
            ElevatedButton(
              onPressed: () {
                // Logic untuk menyimpan data
                print('Nama: ${_namaController.text}');
                print('Deskripsi: ${_deskripsiController.text}');
                print('Tanggal: ${_tanggalController.text}');
                print('Waktu: ${_waktuController.text}');
                print('Kategori: $_selectedCategory');

                // Setelah simpan, kembali ke halaman sebelumnya
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
                style: FontCollections.paragraph1.copyWith(color: ColorCollections.colorWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
