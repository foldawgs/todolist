import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/design_system/styles/font_collections.dart';

class CatatanSuaraPage extends StatelessWidget {
  const CatatanSuaraPage({super.key});

  Stream<List<Map<String, dynamic>>> _readMetadata() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      try {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String metadataPath = '${appDocDir.path}/audio_metadata.json';

        File metadataFile = File(metadataPath);
        if (await metadataFile.exists()) {
          String data = await metadataFile.readAsString();
          List<Map<String, dynamic>> metadataList =
              List<Map<String, dynamic>>.from(jsonDecode(data));
          yield metadataList;
        } else {
          yield [];
        }
      } catch (e) {
        print('Error reading metadata: $e');
        yield [];
      }
    }
  }

  Future<void> _deleteAudioFile(String filePath, String metadataPath) async {
    try {
      // Delete the audio file
      File audioFile = File(filePath);
      if (await audioFile.exists()) {
        await audioFile.delete();
      }

      // Update the metadata
      File metadataFile = File(metadataPath);
      if (await metadataFile.exists()) {
        String data = await metadataFile.readAsString();
        List<Map<String, dynamic>> metadataList =
            List<Map<String, dynamic>>.from(jsonDecode(data));
        metadataList.removeWhere((note) => note['filePath'] == filePath);
        await metadataFile.writeAsString(jsonEncode(metadataList));
      }
    } catch (e) {
      print('Error deleting audio file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Text(
          "Catatan Suara",
          style: FontCollections.h2,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _readMetadata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Belum ada suara nih, rekam dulu yaa!',
                style: FontCollections.paragraph1.copyWith(
                  color: ColorCollections.colorWhite,
                  fontStyle: FontStyle
                      .italic, // Menambahkan sedikit penekanan pada teks
                ),
              ),
            );
          }

          List<Map<String, dynamic>> audioNotes = snapshot.data!;

          return ListView.builder(
            itemCount: audioNotes.length,
            itemBuilder: (context, index) {
              final note = audioNotes[index];
              return ListTile(
                leading:
                    Icon(Icons.play_arrow, color: ColorCollections.primaryBlue),
                title: Text(
                  note['fileName'],
                  style: FontCollections.h4,
                ),
                subtitle: Text(
                  note['description'],
                  style: FontCollections.paragraph1,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String metadataPath =
                        '${appDocDir.path}/audio_metadata.json';
                    await _deleteAudioFile(note['filePath'], metadataPath);
                  },
                ),
                onTap: () async {
                  try {
                    FlutterSoundPlayer player = FlutterSoundPlayer();
                    await player.openPlayer();
                    await player.startPlayer(fromURI: note['filePath']);
                  } catch (e) {
                    print('Error playing audio: $e');
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
