// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
//import '2menutwolevel_page2.dart';
//import '2menutwolevel_page_p.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class FirstScreenWb extends StatefulWidget {
  @override
  State<FirstScreenWb> createState() => _FirstScreenWbState();
}

class _FirstScreenWbState extends State<FirstScreenWb> {
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
      "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/WbTbl?maxRecords=500&view=Grid view",
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
                    child: InkWell(
                      onTap: () => Get.to(const DetailPage(),
                          arguments: [
                            records[index]['fields']['title'],
                            records[index]['fields']['url'],
                            //this.records[index]['fields']['cat1'],
                          ],
                          transition: Transition.zoom),
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
                                fontSize: 20),
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
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 7),
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

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var title = Get.arguments[0];
  var url = Get.arguments[1];
  late WebViewController controller;
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {}),
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url, // https://facebook.com
              onWebViewCreated: (controller) {
                this.controller = controller;
              },
              onPageStarted: (url) {
                print('New website: $url');

                /// Hide Header & Footer
                if (url.contains('www.amazon.com')) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    controller.evaluateJavascript(
                        "document.getElementsByTagName('header')[0].style.display='none'");
                    controller.evaluateJavascript(
                        "document.getElementsByTagName('footer')[0].style.display='none'");
                  });
                }
              },
            ),
          ),
        ));
  }
}
