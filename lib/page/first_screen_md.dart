// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
//import '2menutwolevel_page2.dart';
//import '2menutwolevel_page_p.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:todaylang/page/commentbox.dart';

import 'commentlist.dart';

class FirstScreenMd extends StatefulWidget {
  const FirstScreenMd({Key? key}) : super(key: key);

  @override
  State<FirstScreenMd> createState() => _FirstScreenMdState();
}

class _FirstScreenMdState extends State<FirstScreenMd> {
  List records = [];
  bool loadRemoteDatatSucceed = false;

  // final style = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  // final style1 = const TextStyle(
  //   fontSize: 15,
  // );
// Future<dynamic> _fetchMenus   async {
//   var response = await Dio().get(
//   'https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=Grid view',
//   options: Options(
//       contentType: 'Application/json',
//       headers: {
//         'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
//         'Accept': 'Application/json',
//       },
//     ),
// );
//     try {
//       Map<String, dynamic> result = json.decode(response.body);
//       records = result['records'];
//     } catch (e) {
//       if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 2000);
//     }

//     return records;
//   }
  Future _fetchMenus() async {
    bool loadRemoteDatatSucceed = false;
    final url = Uri.parse(
      //"https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/menus?maxRecords=500&cat2=2",
      "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=Grid view",
      //"https://api.airtable.com/v0/%2FappgEJ6eE8ijZJtAp/menus?%3D1&maxRecords=500&filterByFormula=({cat1}='2')&fields[]=id",
    );
    Map<String, String> header = {"Authorization": "Bearer keyyG7I9nxyG5SmTq"};
    try {
      final response = await http.get(url, headers: header);
      Map<String, dynamic> result = json.decode(response.body);
      records = result['records'];
    } catch (e) {
      if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 2000);
    }

    return records;
  }

  retryFuture(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.list),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.speaker_notes),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.nature_people),
            color: Colors.black,
          )
        ],
      ),
      // ignore: unnecessary_null_comparison
      body: FutureBuilder(
          future: _fetchMenus(),
          builder: (context, snapshot) {
            print('snapshot No.=>');
            print(records.length);

            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.amber),
              ));
            } else {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: records.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(const DetailPage(),
                                arguments: [
                                  records[index]['fields']['title'],
                                  records[index]['fields']['content'],
                                  //this.records[index]['fields']['cat1'],
                                ],
                                transition: Transition.zoom),
                            child: Column(
                              children: [
                                Text(
                                  records[index]['fields']['title'].toString(),
                                  style: GoogleFonts.amiko(
                                      // backgroundColor: Colors.white70,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.justify,
                                ),
                                //const Divider(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                      records[index]['fields']['content']
                                          .toString(),
                                      // style: GoogleFonts.acme(
                                      style: GoogleFonts.nanumGothic(
                                        // backgroundColor: Colors.white70,
                                        // fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2),
                                ),
                                Card(
                                  color: Colors.black54,
                                  shadowColor: Colors.grey,
                                  elevation: 8,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Ink.image(
                                          // image: NetworkImage(
                                          //   this.records[index]['fields']['image_url'].toString(),
                                          // ),
                                          image: const AssetImage(
                                              'assets/images/012.png'),
                                          // colorFilter: ColorFilters.greyscale,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.8),
                                              BlendMode.dstATop),
                                          height: 180,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          records[index]['fields']['title']
                                              .toString(),
                                          // style: GoogleFonts.aBeeZee(
                                          style: GoogleFonts.nanumGothic(
                                              // backgroundColor: Colors.white70,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // Divider(
                                //   indent: 30,
                                // ),
                                IconButton(
                                  icon: Icon(Icons.list, color: Colors.amber),
                                  onPressed: () {
                                    Get.to(CommentWrite());
                                  },
                                ),
                                Text('229'),
                                Divider(
                                  indent: 30,
                                ),
                                Icon(Icons.favorite),
                                Text('1,204'),
                                Divider(
                                  indent: 30,
                                ),
                                Icon(Icons.share),
                                Text('Share!'),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12,
                            thickness: 8.0,
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var title = Get.arguments[0];
  var content = Get.arguments[1];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments[0],
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: buildFAB(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Markdown(
              data: Get.arguments[1],
              styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
              physics: const BouncingScrollPhysics(),
              styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(color: Colors.blue),
                  h2: const TextStyle(color: Colors.blue),
                  h3: const TextStyle(color: Colors.blue),
                  h4: const TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.w100),
                  h5: const TextStyle(
                    color: Colors.black87,
                  ),
                  h6: const TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.w600),
                  p: const TextStyle(
                    color: Colors.black26,
                  ),
                  strong: const TextStyle(color: Colors.lightBlueAccent),
                  blockSpacing: 10.0,
                  listIndent: 24.0,
                  horizontalRuleDecoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 3.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  blockquote: const TextStyle(color: Colors.red))),
        ),
      ),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildNavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        indicatorColor: Colors.blue.shade100,
      ),
      child: NavigationBar(
        height: 60,
        backgroundColor: Color(0xFFf1f5fb),
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // animationDuration: Duration(seconds: 3),
        // ignore: prefer_const_literals_to_create_immutables
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.share_outlined),
            selectedIcon: Icon(Icons.share),
            label: 'Share',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Translation',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Speak',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined, size: 30),
            selectedIcon: Icon(Icons.chat, size: 30),
            label: 'Comment',
          ),
        ],
      ),
    );
  }

  Widget? buildFAB() {
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    switch (index) {
      case 0:
        return Container(
          height: 54,
          child: FloatingActionButton.extended(
            shape: shape,
            icon: Icon(Icons.edit_outlined),
            label: Text('Compose'),
            onPressed: () {},
          ),
        );
      case 1:
        return FloatingActionButton.extended(
          shape: shape,
          icon: Icon(Icons.chat_bubble_outline),
          label: Text('New Chat'),
          onPressed: () {},
        );
      case 2:
        return FloatingActionButton.extended(
          shape: shape,
          icon: Icon(Icons.add),
          label: Text('New Space'),
          onPressed: () {},
        );
      case 3:
        return FloatingActionButton.extended(
          shape: shape,
          icon: Icon(Icons.add),
          label: Text('View Comment'),
          onPressed: () => Get.to(CommentsList()),
        );
      default:
        return null;
    }
  }
}
