// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

//import '2menutwolevel_page2.dart';
//import '2menutwolevel_page_p.dart';

class OpenPage extends StatefulWidget {
  const OpenPage({Key? key}) : super(key: key);

  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  List records = [];
  bool isDownloading = true;

  Future<List> _fetchMenus(
    String view,
  ) async {
    // Response response;
    try {
      Dio dio = Dio();
      var response = await dio.get(
        "https://api.airtable.com/v0/app95nB2yi0WAYDyn/OfTbl?maxRecords=50&view=$view",
        options: Options(contentType: 'Application/json', headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        }),
      );

      Map<String, dynamic> result = (response.data);

      records = result['records'];
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        // if (loadRemoteDatatSucceed == false) retryFuture(_fetchMenus, 200);
      }
    }
    return records;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                  ),
                  child: Text("전체", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    setState(() {
                      print('grivew clicked');
                      _fetchMenus("Gridview");
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      _fetchMenus("Gridview");
                    });
                  },
                ),
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                  ),
                  child: Text("명언", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    setState(() {
                      print('quote clicked');

                      _fetchMenus("quoteview");
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      _fetchMenus("quoteview");
                    });
                  },
                ),
              ],
            ),
            Divider(
              height: 2,
            ),
            Expanded(
              child: FutureBuilder(
                  future: _fetchMenus("Gridview"),
                  builder: (context, snapshot) {
                    // print('snapshot No.=>');
                    // print(records.length);

                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation(Colors.amber),
                      ));
                    } else {
                      return ListView.builder(
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        // ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: records.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Card(
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () => openFile(
                                            url: records[index]['fields']['url']
                                                .toString()
                                            // opt. fileName: 'video.mp4',
                                            )),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      left: 16,
                                      child: Text(
                                        records[index]['fields']['title']
                                            .toString(),
                                        style: GoogleFonts.nanumGothic(
                                          // backgroundColor: Colors.white70,
                                          // fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await (isDownloading ? downloadFile(url, name) : pickFile());
    if (file == null) return;

    print('Path: ${file.path}');
    print('Length: ${file.lengthSync()}');

    OpenFile.open(file.path);
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;

    return File(result.files.first.path!);
  }

  // /// Download file into private folder not visible to user
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
