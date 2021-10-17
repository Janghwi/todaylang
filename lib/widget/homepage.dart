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

import 'tabbar_widget.dart';

class HomePage extends StatelessWidget {
  final String title = "좋은생각";

  // ignore: use_key_in_widget_constructors
  // const HomePage({
  //   required this.title,
  // });

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
          currentIndex: 0,
          onTap: (index) {
            print(index);
          },
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Translate"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Comments"),
          ],
        ),
      );
}
