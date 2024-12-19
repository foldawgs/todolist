import 'package:flutter/material.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:todolist/screen/catatanPage.dart';
import 'package:todolist/design_system/styles/color_collections.dart';
import 'package:todolist/screen/homePage.dart';
import 'package:todolist/profile.dart';
import 'package:todolist/screen/suaraPage.dart';
import 'package:todolist/tambahCatatan.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      actionButton: CurvedActionBar(
          onTab: (value) {
            /// perform action here
            print(value);
          },
          activeIcon: Container(
            padding: EdgeInsets.all(8),
            decoration:
                BoxDecoration(color: ColorCollections.primaryBlue, shape: BoxShape.circle),
            child: Icon(
              Icons.add,
              size: 50,
              color: ColorCollections.colorWhite,
            ),
          ),
          inActiveIcon: Container(
            padding: EdgeInsets.all(8),
            decoration:
                BoxDecoration(color: ColorCollections.primaryBlue, shape: BoxShape.circle),
            child: Icon(
              Icons.add,
              size: 50,
              color: ColorCollections.colorWhite,
            ),
          ),
          text: ""),
      activeColor: ColorCollections.primaryBlue,
      navBarBackgroundColor: ColorCollections.colorWhite,
      inActiveColor: Colors.black45,
      appBarItems: [

        // HOME
        FABBottomAppBarItem(
            activeIcon: Icon(
              Icons.home,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            inActiveIcon: Icon(
              Icons.home,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            text: ''
            ),

        // RECORD
        FABBottomAppBarItem(
            activeIcon: Icon(
              Icons.mic,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            inActiveIcon: Icon(
              Icons.mic,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            text: ''),

        // LIST
        FABBottomAppBarItem(
            activeIcon: Icon(
              Icons.list,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            inActiveIcon: Icon(
              Icons.list,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            text: ''),

        // WALLET
        FABBottomAppBarItem(
            activeIcon: Icon(
              Icons.person,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            inActiveIcon: Icon(
              Icons.person,
              size: 35,
              color: ColorCollections.primaryBlue,
            ),
            text: ''),
      ],

      bodyItems: [
        homePage(),
        CatatanSuaraPage(),
        CatatanPage(),
        ProfilePage()
      ],
      actionBarView: TambahCatatan()
    );
  }
}