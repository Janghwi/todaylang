import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class PhrasesLoader extends GetxController {
  static PhrasesLoader get to => Get.find();
  RxList records = [].obs;
  // RxList records = <Map<String, dynamic>>[].obs;
  @override
  void onInit() async {
    super.onInit();
    _loadPhrasesFile();
  }

  Future<List> _loadPhrasesFile() async {
    if (Get.context != null) {
      Dio dio = Dio();
      var response = await dio.get(
        "https://api.airtable.com/v0/appgEJ6eE8ijZJtAp/goodTest?maxRecords=500&view=Gridview",
        // "https://api.airtable.com/v0/app95nB2yi0WAYDyn/comments?maxRecords=200&view=Gridview",
        options: Options(contentType: 'Application/json', headers: {
          'Authorization': 'Bearer keyyG7I9nxyG5SmTq',
          'Accept': 'Application/json',
        }),
      );
      // print(response.data);

      var result = (response.data);
      print('this passed');
      print(result);

      records = result['records'];

      return records;

      // String data = await DefaultAssetBundle.of(Get.context!)
      //     .loadString("assets/json/post.json");
      // records(json.decode(data).cast<Map<String, dynamic>>().torecords());
    } else {
      Future.delayed(Duration(milliseconds: 200), _loadPhrasesFile);
    }
    return records;
  }
}
