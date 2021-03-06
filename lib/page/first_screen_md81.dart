// ignore_for_file: sized_box_for_whitespace

import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:like_button/like_button.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'commentlist.dart';

enum MenuType { first, second, third }

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFE9D8C0);
// const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF82D9EC);
// const kBlueColor = Color(0xFF40BAD5);

const kDefaultPadding = 20.0;

// var gooHi = GoogleFonts.hiMelody(
var gooHi = GoogleFonts.doHyeon(
    // backgroundColor: Colors.white70,
    fontStyle: FontStyle.normal,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16);

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 10),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);

class FirstScreenMd81 extends StatefulWidget {
  @override
  State<FirstScreenMd81> createState() => _FirstScreenMd81State();
}

class _FirstScreenMd81State extends State<FirstScreenMd81> {
  // const FirstScreenMd({Key? key}) : super(key: key);
  @override
  List records = [];

  bool hasBackground = false;

  // int likeCount = 0;
  // @override
  // void initState() {
  //   _fetchDatas("Gridview");
  //   super.initState();
  // }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<List> _fetchDatas(
    String view,
  ) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=$view",
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
        // if (loadRemoteDatatSucceed == false) retryFuture(_fetchDatas, 200);
      }
    }
    if (mounted) {
      setState(() {
        // ?????? ??? ????????? refresh??? ??????. ????????? ????????? ????????? ??????????????? ??????
      });
    }
    return records;
  }

  retryFuture(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  _readRequest(String? currentId, int readCount) async {
    // print('read clicked');
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
              'readCnt': readCount + 1,
              // 'likeCnt': likeController.text,
            }
          },
        ],
      },
    );
  }

  // final ctr = Get.put(PhrasesLoader());

  bool isLiked = false;
  late String currentView = "Gridview";
  Color mColor = Color(0xFF6200EE),
      mColor0 = Color(0xFF6200EE),
      mColor1 = Color(0xFF6200EE);
  final isSelected = <bool>[false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,

        // ignore: unnecessary_null_comparison
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            if (mounted) {
              setState(() {});
              await _fetchDatas(currentView);
              // await ctr.loadPhrasesFile();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Wrap(
                spacing: 0,
                runSpacing: 0,
                alignment: WrapAlignment.start,
                children: [
                  ToggleButtons(
                    color: Colors.black.withOpacity(0.9),
                    selectedColor: mColor,
                    selectedBorderColor: mColor0,
                    fillColor: mColor1.withOpacity(0.2),
                    splashColor: Colors.grey.withOpacity(0.12),
                    hoverColor: Color(0xFF6200EE).withOpacity(0.04),
                    borderRadius: BorderRadius.circular(4.0),
                    constraints: BoxConstraints(minHeight: 36.0),
                    isSelected: isSelected,
                    onPressed: (index) {
                      // Respond to button selection
                      if (mounted) {
                        setState(() {
                          isSelected[0] = false;
                          isSelected[1] = false;
                          isSelected[2] = false;
                          isSelected[3] = false;
                          isSelected[4] = false;
                          isSelected[5] = false;
                          if (index == 0) {
                            mColor = Colors.blue;
                            mColor0 = Colors.blue;
                            mColor1 = Colors.blue;
                            _fetchDatas("Gridview");
                            currentView = "Gridview";
                          }
                          if (index == 1) {
                            mColor = Colors.blue;
                            mColor0 = Colors.blue;
                            mColor1 = Colors.blue;
                            _fetchDatas("likeview");
                            currentView = "likeview";
                          }
                          if (index == 2) {
                            mColor = Colors.blue;
                            mColor0 = Colors.blue;
                            mColor1 = Colors.blue;
                            _fetchDatas("shareview");
                            currentView = "shareview";
                          }
                          if (index == 3) {
                            mColor = Colors.blue;
                            mColor0 = Colors.blue;
                            mColor1 = Colors.blue;
                            _fetchDatas("readview");
                            currentView = "readview";
                          }
                          if (index == 4) {
                            mColor = Colors.blue;
                            mColor0 = Colors.blue;
                            mColor1 = Colors.blue;
                            _fetchDatas("basicview");
                            currentView = "basicview";
                          }
                          if (index == 5) {
                            mColor = Colors.blue;
                            mColor0 = Colors.blue;
                            mColor1 = Colors.blue;
                            _fetchDatas("advancedview");
                            currentView = "advancedview";
                          }

                          isSelected[index] = !isSelected[index];
                        });
                      }
                    },
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Recent',
                          style: TextStyle(fontSize: 12),

                          // isSelected ? 16 : 14
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Like#',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Share#',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Read#',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Basic',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Advanced',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                    future: _fetchDatas(currentView),
                    builder: (context, snapshot) {
                      // print('snapshot No.=>');
                      // print(records.length);
                      // print("get records:" "{}");
                      // List<bool> isLiked = List.filled(records.length, false);
                      // print('22 builder passed');
                      if (!snapshot.hasData) {
                        return Center(
                            child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: 0.5,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey,
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.amber),
                          ),
                        ));
                      } else {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: records.length,
                            // itemCount: PhrasesLoader.to.records.length,
                            // itemCount: PhrasesLoader.to.records.length,
                            itemBuilder: (BuildContext context, int index) {
                              // List<bool> isLiked = List.filled(records.length, false);
                              // print('PhrasesLoader.to.records.length');
                              // print(snapshot);
                              // print(PhrasesLoader.to.records.length);
                              // print(records[index]['fields']['likeCnt']);
                              // ctr.currentIdSave.value = ctr.records[index]['id'];

                              int likeCount =
                                  records[index]['fields']['likeCnt'];

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _readRequest(records[index]['id'],
                                          records[index]['fields']['readCnt']);
                                      Get.to(() => DetailPage(),
                                          arguments: [
                                            records[index]['fields']['title'],
                                            records[index]['fields']['content'],
                                            records[index]['id'],
                                            records[index]['fields']['likeCnt'],
                                            records[index]['fields']
                                                    ['Attachments'][0]
                                                ['thumbnails']['large']['url']
                                            //this.records[index]['fields']['cat1'],
                                          ],
                                          duration: Duration(seconds: 1),
                                          transition: Transition.fadeIn,
                                          preventDuplicates: false);
                                    },
                                    child: Column(
                                      children: [
                                        ColorFiltered(
                                          colorFilter:
                                              ColorFilter.srgbToLinearGamma(),
                                          // Colors.grey, BlendMode.saturation),
                                          child: Container(
                                            height: 160,
                                            width: 500,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: index.isEven
                                                  ? kBlueColor
                                                  : kSecondaryColor,
                                              boxShadow: const [kDefaultShadow],
                                            ),
                                            // color: Colors.amber,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 20 / 2,
                                            ),
                                            child: Stack(
                                                alignment: Alignment.topLeft,
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: index.isEven
                                                          ? kBlueColor
                                                          : kSecondaryColor,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      boxShadow: [
                                                        kDefaultShadow
                                                      ],
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Hero(
                                                      tag: records[index]['id'],
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        height: 90,
                                                        width: 120,
                                                        child: Opacity(
                                                          opacity: 0.5,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: records[index]
                                                                              [
                                                                              'fields']
                                                                          [
                                                                          'Attachments'][0]
                                                                      [
                                                                      'thumbnails']
                                                                  [
                                                                  'large']['url'],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: size.width - 130,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Spacer(),
                                                          Transform.rotate(
                                                            angle:
                                                                -math.pi / 35,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  records[index]
                                                                              [
                                                                              'fields']
                                                                          [
                                                                          'count']
                                                                      .toString(),
                                                                  // style: GoogleFonts.aBeeZee(
                                                                  // style: GoogleFonts.hiMelody(
                                                                  // style: GoogleFonts.blackHanSans(
                                                                  style: GoogleFonts.blackHanSans(
                                                                      letterSpacing: 0.2,
                                                                      // backgroundColor: Colors.white70,
                                                                      fontStyle: FontStyle.normal,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.amber.shade200,
                                                                      fontSize: 22),
                                                                  // overflow:
                                                                  //     TextOverflow
                                                                  //         .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                                Text(
                                                                  records[index]
                                                                              [
                                                                              'fields']
                                                                          [
                                                                          'title']
                                                                      .toString(),
                                                                  // style: GoogleFonts.aBeeZee(
                                                                  // style: GoogleFonts.hiMelody(
                                                                  // style: GoogleFonts.blackHanSans(
                                                                  style: GoogleFonts.blackHanSans(
                                                                      letterSpacing: 0.2,
                                                                      // backgroundColor: Colors.white70,
                                                                      fontStyle: FontStyle.normal,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.black38,
                                                                      fontSize: 18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      kDefaultPadding *
                                                                          1.5, // 30 padding
                                                                  vertical:
                                                                      kDefaultPadding /
                                                                          4, // 5 top and bottom
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            22),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            22),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  records[index]
                                                                          [
                                                                          'fields']
                                                                      ['level'],
                                                                  style: GoogleFonts.notoSans(
                                                                      // backgroundColor: Colors.white70,
                                                                      fontStyle: FontStyle.italic,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Colors.white,
                                                                      fontSize: 14),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              IconButton(
                                                                iconSize: 20,
                                                                icon: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .grey),
                                                                onPressed: () {
                                                                  Get.to(() {
                                                                    return DetailPage();
                                                                  },
                                                                      arguments: [
                                                                        records[index]['fields']
                                                                            [
                                                                            'title'],
                                                                        records[index]['fields']
                                                                            [
                                                                            'content'],
                                                                        records[index]
                                                                            [
                                                                            'id'],
                                                                        records[index]['fields']
                                                                            [
                                                                            'likeCnt'],
                                                                      ],
                                                                      transition:
                                                                          Transition
                                                                              .zoom,
                                                                      preventDuplicates:
                                                                          true);
                                                                },
                                                              ),
                                                              Text(
                                                                records[index][
                                                                            'fields']
                                                                        [
                                                                        'likeCnt']
                                                                    .toString(),
                                                                style: GoogleFonts
                                                                    .notoSans(
                                                                        // backgroundColor: Colors.white70,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .italic,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ));
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
  var id = Get.arguments[2];
  int likecount = Get.arguments[3];
  var imageUrl = Get.arguments[4];
  int index = 0;
  String? currentIdSave;
  // int? likeCount = likecount ;

  Future<bool> onLikeButtonTapped(
    bool isLiked,
  ) async {
    {
      final response = Dio().patch(
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
              "id": id,
              'fields': {
                'likeCnt': likecount + 1,
                // 'likeCnt': likeCount + 1,
                // 'likeCnt': likeController.text,
              }
            },
          ],
        },
      );
    }
    if (mounted) {
      setState(() {});
    }
    return !isLiked;
  }

  final controller = ScreenshotController();
  Color mColor = Color(0xFF6200EE),
      mColor0 = Color(0xFF6200EE),
      mColor1 = Color(0xFF6200EE);
  final isSelected = <bool>[false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print(content);

    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Get.arguments[0],
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey[200],
                  child: IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      size: 20,
                    ),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey[200],
                  child: LikeButton(
                    // bubblesSize: 25.0,
                    onTap: onLikeButtonTapped,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: buildFAB(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Wrap(
                  spacing: 0,
                  runSpacing: 0,
                  alignment: WrapAlignment.start,
                  children: [
                    ToggleButtons(
                      color: Colors.black.withOpacity(0.9),
                      selectedColor: mColor,
                      selectedBorderColor: mColor0,
                      fillColor: mColor1.withOpacity(0.2),
                      splashColor: Colors.grey.withOpacity(0.12),
                      hoverColor: Color(0xFF6200EE).withOpacity(0.04),
                      borderRadius: BorderRadius.circular(4.0),
                      constraints: BoxConstraints(minHeight: 36.0),
                      isSelected: isSelected,
                      onPressed: (index) {
                        isSelected[0] = false;
                        isSelected[1] = false;
                        isSelected[2] = false;
                        isSelected[3] = false;
                        isSelected[4] = false;
                        isSelected[5] = false;
                        // Respond to button selection
                        if (index == 0) {
                          mColor = Colors.blue;
                          mColor0 = Colors.blue;
                          mColor1 = Colors.blue;
                          Get.to(() => MarkdownWidget(Get.arguments[1]));
                        }
                        if (index == 1) {
                          mColor = Colors.blue;
                          mColor0 = Colors.blue;
                          mColor1 = Colors.blue;
                          Get.to(() => MarkdownWidget(Get.arguments[1]));
                        }

                        isSelected[index] = !isSelected[index];
                      },

                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '?????????',
                            style: TextStyle(fontSize: 12),

                            // isSelected ? 16 : 14
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '?????????',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '??????',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '??????',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '??????',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '??????',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: MarkdownWidget(Get.arguments[1]),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: buildNavigationBar(),
      ),
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
          height: 30,
          child: FloatingActionButton.extended(
            shape: shape,
            icon: Icon(Icons.share),
            label: Text('Capture & Share'),
            backgroundColor: Colors.yellow[400],
            foregroundColor: Colors.black54,
            onPressed: () async {
              final image = await controller.capture();
              // final image = await controller.captureFromWidget(MarkdownWidget());
              // ignore: unnecessary_null_comparison
              if (image == null) return;
              saveAndShare(image);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Screenshot Completed...',
                  style: TextStyle(fontSize: 16),
                ),
                backgroundColor: Colors.blueGrey,
              ));
            },
            // final = image await controller.capture();
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
          onPressed: () => Get.to(() => CommentsList()),
        );
      default:
        return null;
    }
  }
}

class MarkdownWidget extends StatefulWidget {
  const MarkdownWidget(
    param0, {
    Key? key,
    data,
  }) : super(key: key);

  @override
  State<MarkdownWidget> createState() => _MarkdownWidgetState();
}

class _MarkdownWidgetState extends State<MarkdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Markdown(
        data: Get.arguments[1],
        styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
        physics: const BouncingScrollPhysics(),
        styleSheet: MarkdownStyleSheet(
            h1: const TextStyle(color: Colors.black),
            h2: const TextStyle(color: Colors.black),
            h3: const TextStyle(color: Colors.black),
            h4: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w100),
            h5: const TextStyle(
              color: Colors.red,
            ),
            h6: const TextStyle(
                color: Colors.indigo, fontWeight: FontWeight.w600),
            p: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            tableBody: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            tableHead: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
            tableCellsPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            strong: const TextStyle(color: Colors.black87),
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
            blockquote: const TextStyle(color: Colors.red)));
  }
}

Future saveAndShare(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/flutter.png');
  image.writeAsBytesSync(bytes);

  const text = 'Shared From Enkornese';
  await Share.shareFiles([image.path], text: text);
}

Future<String> saveImage(Uint8List bytes) async {
  await [Permission.storage].request();

  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');
  final name = 'screenshot_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);

  return result['filePath'];
}




// list of colors that we use in our app

