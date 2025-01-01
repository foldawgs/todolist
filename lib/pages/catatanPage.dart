import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/pages/detailcatatanPage.dart';
import 'package:intl/intl.dart'; // Import intl untuk format tanggal

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
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todolist')
          .where('selesai', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Terjadi kesalahan saat mengambil data.'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Tidak ada catatan.'),
          );
        }

        final todos = snapshot.data!.docs;

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            final data = todo.data() as Map<String, dynamic>;

            final date = (data['date'] as Timestamp?)?.toDate();
            final formattedDate = date != null
                ? DateFormat('d MMMM yyyy').format(date)
                : 'Tidak ada tanggal';
            final time = date != null
                ? DateFormat('HH:mm').format(date)
                : 'Tidak ada waktu';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailCatatanPage(
                      reference: todo.reference,
                      name: data['name'] ?? '',
                      description: data['description'] ?? '',
                      date: formattedDate,
                      time: time,
                      category: data['category'] ?? '',
                      reminder: data['reminder'] ?? '10 menit sebelumnya',
                    ),
                  ),
                );
              },
              child: _buildCatatan(
                data['name'] ?? '',
                data['description'] ?? '',
                formattedDate,
                time,
                data['category'] ?? '',
                data['selesai'] ?? false,
                todo.reference,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCatatan(String title, String description, String date,
      String time, String category, bool selesai, DocumentReference reference) {
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
            value: selesai,
            onChanged: (bool? value) async {
              await reference.update({'selesai': value});
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontCollections.paragraph2),
                const SizedBox(height: 4),
                Text(description, style: FontCollections.paragraph2),
                const SizedBox(height: 4),
                Text("Tanggal: $date", style: FontCollections.paragraph2),
                const SizedBox(height: 4),
                Text("Waktu: $time", style: FontCollections.paragraph2),
                const SizedBox(height: 4),
                Text("$category", style: FontCollections.paragraph2),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await reference.delete();
            },
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
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todolist')
          .where('selesai', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Terjadi kesalahan saat mengambil data.'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Tidak ada catatan selesai.'),
          );
        }

        final todos = snapshot.data!.docs;

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            final data = todo.data() as Map<String, dynamic>;

            final date = (data['date'] as Timestamp?)?.toDate();
            final formattedDate = date != null
                ? DateFormat('d MMMM yyyy').format(date)
                : 'Tidak ada tanggal';
            final time = date != null
                ? DateFormat('HH:mm').format(date)
                : 'Tidak ada waktu';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailCatatanPage(
                      reference: todo.reference,
                      name: data['name'] ?? '',
                      description: data['description'] ?? '',
                      date: formattedDate,
                      time: time,
                      category: data['category'] ?? '',
                      reminder: data['reminder'] ?? '10 menit sebelumnya',
                    ),
                  ),
                );
              },
              child: _buildCatatanSelesai(
                data['name'] ?? '',
                data['description'] ?? '',
                formattedDate,
                time,
                data['category'] ?? '',
                todo.reference,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCatatanSelesai(String title, String description, String date,
      String time, String category, DocumentReference reference) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorCollections.colorWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await reference.update({'selesai': false});
            },
            child: const Icon(Icons.check_circle, color: Colors.green),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontCollections.paragraph2),
                const SizedBox(height: 4),
                Text(description, style: FontCollections.paragraph2),
                const SizedBox(height: 4),
                Text("Tanggal: $date", style: FontCollections.paragraph2),
                Text("Waktu: $time", style: FontCollections.paragraph2),
                Text("$category", style: FontCollections.paragraph2),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await reference.delete();
            },
          ),
        ],
      ),
    );
  }
}
