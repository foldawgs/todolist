import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class EditCatatanPage extends StatefulWidget {
  final DocumentReference reference;
  final String name;
  final String description;
  final String date;
  final String time;
  final String category;

  const EditCatatanPage({
    Key? key,
    required this.reference,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
  }) : super(key: key);

  @override
  _EditCatatanPageState createState() => _EditCatatanPageState();
}

class _EditCatatanPageState extends State<EditCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late String _selectedCategory;

  final List<String> _categories = ['Kategori 1', 'Kategori 2', 'Kategori 3'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _descriptionController = TextEditingController(text: widget.description);
    _dateController = TextEditingController(text: widget.date);
    _timeController = TextEditingController(text: widget.time);
    _selectedCategory = widget.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Text(
          "Edit Catatan",
          style: FontCollections.h2,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama",
                  labelStyle: FontCollections.paragraph1,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorCollections.primaryBlue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
                style: FontCollections.paragraph1,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Deskripsi",
                  labelStyle: FontCollections.paragraph1,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorCollections.primaryBlue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong";
                  }
                  return null;
                },
                style: FontCollections.paragraph1,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Tanggal",
                  labelStyle: FontCollections.paragraph1,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorCollections.primaryBlue),
                  ),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    _dateController.text =
                        "${date.year}-${date.month}-${date.day}";
                  }
                },
                style: FontCollections.paragraph1,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Waktu",
                  labelStyle: FontCollections.paragraph1,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorCollections.primaryBlue),
                  ),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    _timeController.text =
                        "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
                  }
                },
                style: FontCollections.paragraph1,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: FontCollections.paragraph1,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Kategori",
                  labelStyle: FontCollections.paragraph1,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorCollections.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    // Menggabungkan date dan time menjadi DateTime
                    List<String> dateParts = _dateController.text.split('-');
                    List<String> timeParts = _timeController.text.split(':');
                    DateTime dateTime = DateTime(
                      int.parse(dateParts[0]), // Year
                      int.parse(dateParts[1]), // Month
                      int.parse(dateParts[2]), // Day
                      int.parse(timeParts[0]), // Hour
                      int.parse(timeParts[1]), // Minute
                    );

                    // Mengonversi DateTime ke Firestore Timestamp
                    Timestamp firestoreTimestamp = Timestamp.fromDate(dateTime);

                    // Simpan data ke Firestore
                    await widget.reference.update({
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'date': firestoreTimestamp, // Simpan sebagai Timestamp
                      'category': _selectedCategory,
                    });

                    // Berikan notifikasi berhasil
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Catatan berhasil diperbarui")),
                    );

                    // Kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  } catch (e) {
                    // Tampilkan pesan kesalahan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Terjadi kesalahan: $e")),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorCollections.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              ),
              child: Text(
                "Simpan",
                style: FontCollections.paragraph1.copyWith(
                  color: ColorCollections.colorWhite,
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
