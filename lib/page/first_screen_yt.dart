// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
//import '2menutwolevel_page2.dart';
//import '2menutwolevel_page_p.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FirstScreenYt extends StatefulWidget {
  @override
  State<FirstScreenYt> createState() => _FirstScreenYtState();
}

class _FirstScreenYtState extends State<FirstScreenYt> {
  List records = [];

  // final style = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  // final style1 = const TextStyle(
  //   fontSize: 15,
  // );

  Future _fetchMenus() async {
    bool loadRemoteDatatSucceed = false;
    final url = Uri.parse(
      //"https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/menus?maxRecords=500&view=Gridview",
      //"https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/menus?maxRecords=500&cat2=2",
      "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/YtTbl?maxRecords=500&view=Gridview",
      //"https://api.airtable.com/v0/%2FappgEJ6eE8ijZJtAp/menus?%3D1&maxRecords=500&filterByFormula=({cat1}='2')&fields[]=id",
      //"https://api.airtable.com/v0/%2FappgEJ6eE8ijZJtAp/menus?fields%5B%5D=&filterByFormula=%7Bcat1%7D+%3D+%222%22',
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
            // print('snapshot No.=>');
            // print(records.length);

            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.amber),
              ));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Get.to(const YoutubePage(),
                        arguments: [
                          records[index]['fields']['content'],
                          records[index]['fields']['vid'],
                          records[index]['fields']['details'],
                          //this.records[index]['fields']['cat1'],
                        ],
                        transition: Transition.zoom),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            records[index]['fields']['title'].toString(),
                            style: GoogleFonts.nanumGothic(
                                // backgroundColor: Colors.white70,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                          //const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                                records[index]['fields']['content'].toString(),
                                style: GoogleFonts.nanumGothic(
                                  // backgroundColor: Colors.white70,
                                  // fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ),

                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

class YoutubePage extends StatefulWidget {
  const YoutubePage({Key? key}) : super(key: key);

  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  var content = Get.arguments[0];
  var vid = Get.arguments[1];
  var details = Get.arguments[2];

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: vid,
      params: const YoutubePlayerParams(
        // playlist: [
        //   'tQjAgEU8Ww0',
        //   'K18cpp_-gP8',
        //   'iLnmTe5Q2Qw',
        //   '_WoCV4c6XOE',
        //   'KmzdUe0RSJo',
        //   '6jZDSSZZxjQ',
        //   'p2lYr3vM_1w',
        //   '7QUtEmBT_-w',
        //   '34_PXCzGw1M',
        // ],
        startAt: Duration(minutes: 0, seconds: 10),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );

    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();

    return Scaffold(
        //extendBodyBehindAppBar: false,
        // appBar: AppBar(
        //   title: Text(
        //     Get.arguments[0],
        //     style: const TextStyle(color: Colors.black, fontSize: 16),
        //   ),
        //   backgroundColor: Colors.grey,
        //   elevation: 0,
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.list),
        //       color: Colors.black,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.speaker_notes),
        //       color: Colors.black,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.nature_people),
        //       color: Colors.black,
        //     )
        //   ],
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          // onPressed: () => _goBack(),
          tooltip: 'stop/start',
          child: const Icon(Icons.pause),
        ),
        // ignore: unnecessary_null_comparison
        body: YoutubePlayerControllerProvider(
          // Passing controller to widgets below.
          controller: _controller,
          child: Column(
            children: [
              player,
              YoutubeValueBuilder(
                controller: _controller,
                builder: (context, value) {
                  return AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Material(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              YoutubePlayerController.getThumbnail(
                                videoId: vid,
                                quality: ThumbnailQuality.medium,
                              ),
                            ),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    crossFadeState: value.isReady
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                  );
                },
              ),
              // Expanded(
              //   child: ListView(
              //     children: [
              //       Divider(
              //         thickness: 2,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           details.toString(),
              //           style: GoogleFonts.lato(
              //               // backgroundColor: Colors.white70,
              //               fontStyle: FontStyle.normal,
              //               color: Colors.black,
              //               fontWeight: FontWeight.w300,
              //               fontSize: 17),
              //           textAlign: TextAlign.justify,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Markdown(
                    data: details.toString(),
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
                          color: Colors.black45,
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
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
