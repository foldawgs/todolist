import 'package:flutter/material.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/design_system/styles/font_collections.dart';
import 'package:todolist/notifikasi.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

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
            Text(
              'User!',
              style: FontCollections.h2,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: ColorCollections.primaryBlue),
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
                        Text(
                          '25 Catatan',
                          style: FontCollections.h2
                              .copyWith(color: ColorCollections.colorWhite),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Anda sangat produktif \nsekali, semangat!',
                          style: FontCollections.paragraph3
                              .copyWith(color: ColorCollections.colorWhite),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/depan.png',
                      height: 200.0,
                      width: 200.0,
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
                'Deadline',
                style: FontCollections.h2,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: ColorCollections.colorWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz PPB',
                          style: FontCollections.h3,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Sabtu, 3 Oktober 2024 \n23:00 pm',
                          style: FontCollections.paragraph3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: ColorCollections.colorWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz UX',
                          style: FontCollections.h3,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Selasa, 8 Oktober 2024 \n23:00 pm',
                          style: FontCollections.paragraph3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: ColorCollections.colorWhite,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tugas UX',
                          style: FontCollections.h3,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Selasa, 8 Oktober 2024 \n23:00 pm',
                          style: FontCollections.paragraph3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
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
                            height: 90.0,
                            width: 90.0,
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            'Quiz Kuliah',
                            style: FontCollections.h2,
                            textAlign:TextAlign.start,
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
                            height: 90.0,
                            width: 90.0,
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            'Tugas Kelompok',
                            style: FontCollections.h2,
                            textAlign:TextAlign.start,
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
                            height: 90.0,
                            width: 90.0,
                          ),
                          SizedBox(width: 40.0),
                          Text(
                            'presentasi',
                            style: FontCollections.h2,
                            textAlign:TextAlign.start,
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
