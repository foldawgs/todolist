import 'package:flutter/material.dart';
import 'package:todolist/dbHelper.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class FormCatatanPage extends StatefulWidget {
  const FormCatatanPage({super.key});

  @override
  _FormCatatanPageState createState() => _FormCatatanPageState();
}

class _FormCatatanPageState extends State<FormCatatanPage> {
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
          "Form Catatan",
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
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Deskripsi
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Tanggal
            TextField(
              controller: _tanggalController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today,
                      color: ColorCollections.primaryBlue),
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() {
                        _tanggalController.text =
                            '${date.day}-${date.month}-${date.year}';
                      });
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Waktu
            TextField(
              controller: _waktuController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Waktu',
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time,
                      color: ColorCollections.primaryBlue),
                  onPressed: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _waktuController.text =
                            '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                      });
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Kategori
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
              onPressed: () async {
                // Mendapatkan data dari form
                String name = _namaController.text;
                String description = _deskripsiController.text;
                String date = _tanggalController.text;
                String time = _waktuController.text;
                String category = _selectedCategory ?? '';

                // Memanggil DBHelper untuk menyimpan catatan
                DBHelper dbHelper = DBHelper();
                await dbHelper.addTodolist(
                    name, description, date, time, category);

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
                style: FontCollections.paragraph1
                    .copyWith(color: ColorCollections.colorWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
