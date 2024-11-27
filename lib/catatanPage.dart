import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  _CatatanPageState createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        title: Text(
          "Catatan",
          style: FontCollections.h2,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
              'Semua Catatan',
              style: FontCollections.h4,
              ),
            ),
            Tab(
              child: Text(
              'Catatan Selesai',
              style: FontCollections.h4,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _SemuaCatatanPage(),
          _CatatanSelesaiPage(),
        ],
      ),
    );
  }
}

class _SemuaCatatanPage extends StatelessWidget {
  const _SemuaCatatanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCatatan("Catatan 1", "Deskripsi catatan 1"),
        _buildCatatan("Catatan 2", "Deskripsi catatan 2"),
      ],
    );
  }

  Widget _buildCatatan(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorCollections.colorWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (bool? value) {},
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontCollections.paragraph2),
                SizedBox(height: 4),
                Text(description, style: FontCollections.paragraph2),
                SizedBox(height: 4),
                Text("Tanggal: 2024-11-27", style: FontCollections.paragraph2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CatatanSelesaiPage extends StatelessWidget {
  const _CatatanSelesaiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCatatanSelesai(
            "Catatan Selesai 1", "Deskripsi catatan selesai 1"),
        _buildCatatanSelesai(
            "Catatan Selesai 2", "Deskripsi catatan selesai 2"),
      ],
    );
  }

  Widget _buildCatatanSelesai(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorCollections.colorWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Checkbox(
            value: true,
            onChanged: (bool? value) {},
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontCollections.paragraph2),
                SizedBox(height: 4),
                Text(description, style: FontCollections.paragraph2),
                SizedBox(height: 4),
                Text("Tanggal: 2024-11-27", style: FontCollections.paragraph2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
