import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class CatatanSuaraPage extends StatelessWidget {
  const CatatanSuaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        scrolledUnderElevation: 0,
        title: Center(
          child: Text(
            "Catatan Suara",
            style: FontCollections.h2,
          ),
        ),
      ),
      body: Column(
        // Column untuk menampung Expanded dan ListView
        children: [
          Expanded(
            // Gunakan Expanded untuk membuat ListView mengisi sisa ruang
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: ColorCollections.colorWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow, // Ikon play
                        color: ColorCollections
                            .primaryBlue, // Sesuaikan warna ikon
                      ),
                      SizedBox(
                          width: 10), // Memberikan jarak antara ikon dan teks
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Agar teks rata kiri
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Vertikal center
                        children: [
                          Text(
                            'Latihan presentasi',
                            style: FontCollections
                                .h3, // Ganti dengan font style h3
                          ),
                          SizedBox(
                              height:
                                  8.0), // Jarak antara teks pertama dan kedua
                          Text(
                            'Presentasi mata kuliah manajemen proses.',
                            style: FontCollections
                                .paragraph3, // Ganti dengan font style paragraf
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Konten tambahan lainnya bisa ditambahkan di sini
              ],
            ),
          ),
        ],
      ),
    );
  }
}
