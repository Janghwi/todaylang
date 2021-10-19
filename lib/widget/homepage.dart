import 'package:flutter/material.dart';
import 'package:todaylang/page/first_screen_ad.dart';
import 'package:todaylang/page/first_screen_ai.dart';
import 'package:todaylang/page/first_screen_dt.dart';
import 'package:todaylang/page/first_screen_md1.dart';
import 'package:todaylang/page/first_screen_of.dart';
import 'package:todaylang/page/first_screen_wb.dart';
import 'package:todaylang/page/first_screen_wb1.dart';
import 'package:todaylang/page/first_screen_yt.dart';
import 'package:todaylang/page/first_screen_ytLan.dart';
import 'package:todaylang/page/postpage.dart';

import 'tabbar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = "좋은생각";

  // ignore: use_key_in_widget_constructors
  int currentIndex = 0;
  final screens = [
    HomePage(),
    PostPage(),
    PostPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: TabBarWidget(
          title: title,
          tabs: const [
            Tab(
              text: '좋은글',
              // icon: Icon(Icons.feed_outlined),
            ),
            Tab(
              text: '아코디언',
              // icon: Icon(Icons.dynamic_feed),
            ),
            Tab(
              text: 'Ai',
              // icon: Icon(Icons.dynamic_form_sharp),
            ),
            Tab(
              text: '디지털트윈',
              // icon: Icon(Icons.dynamic_form_sharp),
            ),
            Tab(
              text: '웹뷰',
              // icon: Icon(Icons.dynamic_form_sharp),
            ),
            Tab(
              text: '웹뷰1',
              // icon: Icon(Icons.dynamic_form_sharp),
            ),
            Tab(
              text: '유투브언어',
              // icon: Icon(Icons.favorite_border),
            ),
            Tab(
              text: '유투브',
              // icon: Icon(Icons.favorite_border),
            ),
            Tab(
              text: '오픈파일',
              // icon: Icon(Icons.favorite_border),
            ),
          ],
          children: [
            FirstScreenMd1(),
            FirstScreenAd(),
            FirstScreenAi(),
            FirstScreenDt(),
            FirstScreenWb(),
            FirstScreenWb1(),
            // const BarMenu(),
            FirstScreenYtLan(),
            FirstScreenYt(),
            OpenPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          iconSize: 20,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: "Translate",
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Comments",
                backgroundColor: Colors.blue),
          ],
        ),
      );
}
