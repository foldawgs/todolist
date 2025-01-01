import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/design_system/styles/font_collections.dart';

class FormSuaraPage extends StatefulWidget {
  const FormSuaraPage({super.key});

  @override
  _FormSuaraPageState createState() => _FormSuaraPageState();
}

class _FormSuaraPageState extends State<FormSuaraPage> {
  final TextEditingController _deskripsiController = TextEditingController();
  String? _selectedKategori;
  final List<String> _kategoriList = ['Kategori 1', 'Kategori 2', 'Kategori 3'];

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _audioFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _audioRecorder?.openRecorder();
  }

  Future<void> _startRecording() async {
    try {
      if (_audioRecorder != null && !_audioRecorder!.isRecording) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath =
            '${appDocDir.path}/audio_note_${DateTime.now().millisecondsSinceEpoch}.aac';

        await _audioRecorder?.startRecorder(toFile: filePath);
        setState(() {
          _isRecording = true;
          _audioFilePath = filePath;
        });
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder?.stopRecorder();
      setState(() {
        _isRecording = false;
      });

      if (path != null) {
        print('Rekaman berhasil disimpan di: $path');
      } else {
        print('Rekaman gagal disimpan.');
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _saveMetadata(String description, String category) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String metadataPath = '${appDocDir.path}/audio_metadata.json';

      File metadataFile = File(metadataPath);
      List<Map<String, dynamic>> metadataList = [];

      if (await metadataFile.exists()) {
        String existingData = await metadataFile.readAsString();
        metadataList =
            List<Map<String, dynamic>>.from(jsonDecode(existingData));
      }

      metadataList.add({
        'fileName': _audioFilePath!.split('/').last,
        'description': description,
        'category': category,
        'filePath': _audioFilePath,
        'created_at': DateTime.now().toIso8601String(),
      });

      await metadataFile.writeAsString(jsonEncode(metadataList));
      print('Metadata berhasil disimpan.');
    } catch (e) {
      print('Error saving metadata: $e');
    }
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    _audioRecorder = null;
    super.dispose();
  }

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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              items: _kategoriList.map((String kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori, style: FontCollections.paragraph3),
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
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorCollections.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              ),
              child: Text(
                _isRecording ? 'Merekam...' : 'Rekam Suara',
                style: FontCollections.paragraph1
                    .copyWith(color: ColorCollections.colorWhite),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_audioFilePath != null) {
                  await _saveMetadata(
                    _deskripsiController.text,
                    _selectedKategori ?? '',
                  );
                  Navigator.pop(context);
                } else {
                  print('Tidak ada file rekaman untuk disimpan.');
                }
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
            ),
          ],
        ),
      ),
    );
  }
}
