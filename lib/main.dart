import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:staggered_gridview_example/widget/basic_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/custom_scroll_view_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/dynamic_size_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/tabbar_widget.dart';

import 'page/barmenu.dart';
import 'page/comments.dart';
import 'page/first_screen.dart';
import 'page/first_screen_ad.dart';
import 'page/first_screen_ai.dart';
import 'page/first_screen_dt.dart';
import 'page/first_screen_md.dart';
import 'page/first_screen_wb.dart';
import 'page/first_screen_yt.dart';
import 'page/first_screen_yt_nobutton.dart';
import 'page/first_screen_ytLan.dart';
import 'page/postpage.dart';
import 'widget/tabbar_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = '좋은생각';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.light(),
        home: const MainPage(title: title),
      );
}

class MainPage extends StatelessWidget {
  final String title;

  // ignore: use_key_in_widget_constructors
  const MainPage({
    required this.title,
  });

  @override
  Widget build(BuildContext context) => TabBarWidget(
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
            text: '메뉴',
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
            text: '코멘트',
            // icon: Icon(Icons.favorite_border),
          ),
          Tab(
            text: '포스트',
            // icon: Icon(Icons.favorite_border),
          ),
        ],
        children: [
          FirstScreenMd(),
          FirstScreenAd(),
          FirstScreenAi(),
          FirstScreenDt(),
          FirstScreenWb(),
          const BarMenu(),
          FirstScreenYtLan(),
          FirstScreenYt(),
          const CommentsPage(),
          PostPage(),
        ],
      );
}
