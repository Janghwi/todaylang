import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class LangController extends GetxController {
  // static LangController get to => Get.find();

  var setLang = 'kor'.obs;
  // var devLang = Get.deviceLocale;
  // RxString get setLang => _setLang;

  void engLoad(String setLang) {
    setLang = 'eng';

    update();
  }

  void langSet(String setLang) {
    var devLang = Get.deviceLocale;
    print('getx');
    print(devLang);
    // ignore: unrelated_type_equality_checks
    if (devLang == 'ko_KR') {
      setLang = 'kor';
      // ignore: unrelated_type_equality_checks
    } else if (devLang == 'en_US') {
      setLang = 'eng';

      // ignore: unrelated_type_equality_checks
    } else if (devLang == 'ja_JP') {
      setLang = 'jap';
    } else {
      setLang = 'eng';
    }
    update();
  }
}
