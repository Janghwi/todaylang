import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:staggered_gridview_example/widget/basic_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/custom_scroll_view_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/dynamic_size_grid_widget.dart';
// import 'package:staggered_gridview_example/widget/tabbar_widget.dart';

import 'page/first_screen.dart';
import 'page/first_screen1.dart';
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
            text: ' 좋은글 ',
            // icon: Icon(Icons.feed_outlined),
          ),
          Tab(
            text: ' 명언 ',
            // icon: Icon(Icons.dynamic_feed),
          ),
          Tab(
            text: ' 자기개발 ',
            // icon: Icon(Icons.dynamic_form_sharp),
          ),
          Tab(
            text: ' 자기개발 ',
            // icon: Icon(Icons.dynamic_form_sharp),
          ),
          Tab(
            text: ' 즐겨찾기',
            // icon: Icon(Icons.favorite_border),
          ),
        ],
        children: [
          FirstScreen1(),
          FirstScreen1(),
          FirstScreen1(),
          FirstScreen1(),
          FirstScreen1(),
        ],
      );
}
