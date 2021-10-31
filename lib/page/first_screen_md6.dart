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
import 'package:like_button/like_button.dart';
import 'package:todaylang/controllers/phrase_loader.dart';
import 'package:todaylang/widget/commentbox.dart';
import 'package:todaylang/widget/commentbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:todaylang/widget/like_button.dart';

import 'commentlist.dart';

class FirstScreenMd6 extends StatefulWidget {
  const FirstScreenMd6({Key? key}) : super(key: key);

  // const FirstScreenMd({Key? key}) : super(key: key);

  @override
  State<FirstScreenMd6> createState() => _FirstScreenMd6State();
}

class _FirstScreenMd6State extends State<FirstScreenMd6> {
  List records = [];

  bool hasBackground = false;
  // int likeCount = 0;
  // String? currentId;

  // final key1 = GlobalKey();
  late GlobalKey<LikeButtonState> _globalkey;

  @override
  void initState() {
    // Initialize the values here
    super.initState();
    _globalkey = GlobalKey<LikeButtonState>();
  }

  @override
  void dispose() {
    // Remember that you have to dispose of the controllers once the widget is ready to be disposed of
    _globalkey;
    super.dispose();
  }

  // final TextEditingController likeController = TextEditingController();
  // final gkey = GlobalKey<LikeButtonState>();

  // Future _fetchMenus() async {
  //   bool loadRemoteDatatSucceed = false;
  //   final url = Uri.parse(
  //     "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=Gridview",
  //   );
  //   Map<String, String> header = {"Authorization": "Bearer keyyG7I9nxyG5SmTq"};
  //   try {
  //     final response = await http.get(url, headers: header);
  //     Map<String, dynamic> result = json.decode(response.body);
  //     records = result['records'];
  //   } catch (e) {
  //     if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 2000);
  //   }
  //   return records;
  // }
  Future<List> _fetchMenus(
      //  String view,
      ) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=Gridview",
        // "https://api.airtable.com/v0/app95nB2yi0WAYDyn/comments?maxRecords=200&view=Gridview",
        options: Options(contentType: 'Application/json', headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        }),
      );

      Map<String, dynamic> result = (response.data);

      records = result['records'];
    } on DioError catch (e) {
      if (e.response != null) {
      } else {
        // if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 200);
      }
    }
    return records;
  }

  Future<List> _fetchComments(
      //  String view,
      ) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        // "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=Gridview",
        "https://api.airtable.com/v0/app95nB2yi0WAYDyn/comments?maxRecords=500&view=Gridview",
        options: Options(contentType: 'Application/json', headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        }),
      );

      Map<String, dynamic> result = (response.data);

      records = result['records'];
    } on DioError catch (e) {
      if (e.response != null) {
      } else {
        // if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 200);
      }
    }
    return records;
  }

  retryFuture(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  _postRequest(String? currentId, int likeCount) async {
    final response = await Dio().patch(
      'https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest',
      options: Options(
        contentType: 'Application/json',
        headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        },
      ),
      data: {
        'records': [
          {
            "id": currentId,
            'fields': {
              'likeCnt': likeCount,
              // 'likeCnt': likeController.text,
            }
          },
        ],
      },
    );
  }

  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final animationDuration = Duration(milliseconds: 1500);

    return Scaffold(
        extendBodyBehindAppBar: true,

        // ignore: unnecessary_null_comparison
        body: Obx(() => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: PhrasesLoader.to.records.length,
            itemBuilder: (BuildContext context, int index) {
              List<bool> isLiked = List.filled(records.length, false);
              // print(records[index]['id']);
              // print(records[index]['fields']['likeCnt']);
              // likeCount = records[index]['fields']['likeCnt'];
              // String? currentIdSave = records[index]['id'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(const DetailPage(),
                          arguments: [
                            PhrasesLoader.to.records[index]['fields']['title'],
                            PhrasesLoader.to.records[index]['fields']
                                ['content'],
                            //this.records[index]['fields']['cat1'],
                          ],
                          transition: Transition.zoom),
                      child: Column(
                        children: [
                          Text(
                            PhrasesLoader.to.records[index]['fields']['title']
                                .toString(),
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
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                                PhrasesLoader
                                    .to.records[index]['fields']['content']
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
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CachedNetworkImage(
                                imageUrl: PhrasesLoader.to.records[index]
                                        ['fields']['Attachments'][0]
                                    ['thumbnails']['large']['url'],
                                // imageUrl: records[index]['fields']
                                // ['Attachments'][0]['url'],
                                // "https://dl.airtable.com/.attachmentThumbnails/1a21f5107f12e695ea42fa2e79f43d0a/9d11f011",
                                fit: BoxFit.cover,
                                width: MediaQuery.maybeOf(context)!.size.width *
                                    0.97,
                                height:
                                    MediaQuery.maybeOf(context)!.size.height *
                                        0.2,
                              ),
                              Text(
                                PhrasesLoader
                                    .to.records[index]['fields']['title']
                                    .toString(),
                                // style: GoogleFonts.aBeeZee(
                                // style: GoogleFonts.hiMelody(
                                // style: GoogleFonts.blackHanSans(
                                style: GoogleFonts.stylish(
                                    // backgroundColor: Colors.white70,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                    fontSize: 24),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Divider(
                          //   indent: 30,
                          // ),
                          IconButton(
                            icon:
                                Icon(Icons.speaker_notes, color: Colors.amber),
                            onPressed: () {
                              Get.to(CommentWrite());
                            },
                          ),
                          // Divider(
                          //   indent: 10,
                          // ),
                          Text(PhrasesLoader
                              .to.records[index]['fields']['cmtCnt']
                              .toString()),
                          Divider(
                            indent: 30,
                          ),
                          //--------------------------------------------------------
                          GestureDetector(
                            child: IconButton(
                              icon: isLiked[index]
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.grey,
                                    ),
                              // size: 28.0,
                              color: Colors.pink,
                              onPressed: () async {
                                int likeCount =
                                    records[index]['fields']['likeCnt'];
                                int count = 0;
                                if (!isLiked[index] && count == 0) {
                                  print("pressed 1setstate passed :");
                                  likeCount += 1;
                                  _postRequest(records[index]['id'], likeCount);
                                  count = 1;
                                  isLiked[index] = !isLiked[index];
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          // handleLikePost(records[index]['id']),
                          Divider(
                            indent: 10,
                          ),
                          Text(records[index]['fields']['likeCnt'].toString()),

                          // Divider(
                          //   indent: 10,
                          // ),
                          // Icon(Icons.share),
                          // Text('Share!'),
                        ],
                      ),
                    ),
                    // Divider(
                    //   color: Colors.black12,
                    //   thickness: 8.0,
                    // ),
                  ],
                ),
              );
            })));
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  // const DetailPage({Key? key}) : super(key: key);

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
      // bottomNavigationBar: buildNavigationBar(),
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
            icon: Icon(Icons.share),
            label: Text('Services'),
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
