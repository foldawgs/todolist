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

  bool _isLoading = false;

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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorCollections.primaryBlue,
                    ),
                  )
                : ElevatedButton(
                    onPressed: _saveNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorCollections.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                    ),
                    child: Text(
                      'Simpan',
                      style: FontCollections.paragraph1
                          .copyWith(color: ColorCollections.colorWhite),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveNote() async {
  setState(() {
    _isLoading = true;
  });

  String name = _namaController.text;
  String description = _deskripsiController.text;
  String date = _tanggalController.text;
  String time = _waktuController.text;
  String category = _selectedCategory ?? '';

  if (name.isEmpty ||
      description.isEmpty ||
      date.isEmpty ||
      time.isEmpty ||
      category.isEmpty) {
    setState(() {
      _isLoading = false;
    });
    _showTopSnackbar(context, 'Harap isi semua kolom.');
    return;
  }

  try {
    DBHelper dbHelper = DBHelper();
    await dbHelper.addTodolist(name, description, date, time, category);
    _showTopSnackbar(context, 'Catatan berhasil disimpan.');
    Navigator.pop(context);
  } catch (e) {
    _showTopSnackbar(context, 'Gagal menyimpan catatan: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

void _showTopSnackbar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 3)).then((_) => overlayEntry.remove());
}

}
