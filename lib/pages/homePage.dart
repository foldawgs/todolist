import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/pages/notifikasiPage.dart';
import 'package:intl/intl.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  Future<String> getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userData['username'] ?? 'User';
    }
    return 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorCollections.backgroundColor,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello!',
              style: FontCollections.h4,
            ),
            FutureBuilder<String>(
              future: getUsername(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    'Loading...',
                    style: FontCollections.h2,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error!',
                    style: FontCollections.h2,
                  );
                } else {
                  return Text(
                    snapshot.data ?? 'User',
                    style: FontCollections.h2,
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon:
                Icon(Icons.notifications, color: ColorCollections.primaryBlue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pageNotifikasi()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: ColorCollections.primaryBlue,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collection('todolist')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                'Menghitung...',
                                style: FontCollections.h2.copyWith(
                                  color: ColorCollections.colorWhite,
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Text(
                                'Error!',
                                style: FontCollections.h2.copyWith(
                                  color: ColorCollections.colorWhite,
                                ),
                              );
                            }
                            final todoCount = snapshot.data?.docs.length ?? 0;
                            return Text(
                              '$todoCount Catatan',
                              style: FontCollections.h2.copyWith(
                                color: ColorCollections.colorWhite,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Anda sangat produktif \nsekali, semangat!',
                          style: FontCollections.paragraph3.copyWith(
                            color: ColorCollections.colorWhite,
                          ),
                          maxLines: 2, // Batasi teks hingga 2 baris
                          overflow: TextOverflow
                              .ellipsis, // Potong teks jika lebih panjang
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/depan.png',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Catatan',
                style: FontCollections.h2,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 130,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('todolist')
                    .where('selesai',
                        isEqualTo:
                            false) // Menampilkan catatan yang belum selesai
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Terjadi kesalahan saat mengambil data.',
                        style: FontCollections.paragraph1,
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada catatan, bisa santuy dulu!',
                        style: FontCollections.paragraph1,
                      ),
                    );
                  }
                  final todos = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      final data = todo.data() as Map<String, dynamic>;
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: ColorCollections.colorWhite,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name'] ?? 'Catatan',
                              style: FontCollections.h3,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              data['category'] ?? 'Tanpa Kategori',
                              style: FontCollections.paragraph3.copyWith(
                                color: ColorCollections.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Tanggal: ${DateFormat('d MMMM yyyy').format((data['date'] as Timestamp?)?.toDate() ?? DateTime.now())}',
                              style: FontCollections.paragraph3,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Pukul: ${DateFormat('HH:mm').format((data['date'] as Timestamp?)?.toDate() ?? DateTime.now())}',
                              style: FontCollections.paragraph3,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kategori Catatan',
                style: FontCollections.h2,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      color: ColorCollections.colorWhite,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/quiz.png',
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            'Quiz Kuliah',
                            style: FontCollections.h4,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      color: ColorCollections.colorWhite,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/kelompok.png',
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            'Tugas Kelompok',
                            style: FontCollections.h4,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 125,
                    decoration: BoxDecoration(
                      color: ColorCollections.colorWhite,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/presentasi.png',
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            'Presentasi',
                            style: FontCollections.h4,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
