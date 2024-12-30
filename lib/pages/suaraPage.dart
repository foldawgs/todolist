import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catatan Suara")),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _readMetadata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Belum ada catatan suara'),
            );
          }

          List<Map<String, dynamic>> audioNotes = snapshot.data!;

          return ListView.builder(
            itemCount: audioNotes.length,
            itemBuilder: (context, index) {
              final note = audioNotes[index];
              return ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text(note['fileName']),
                subtitle: Text(note['description']),
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
