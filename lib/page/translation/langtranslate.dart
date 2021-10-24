// ignore_for_file: file_names

// ignore: constant_identifier_names
import 'package:get/get.dart';

class LangTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'appbar_title1': '문장',
          'appbar_title2': '단어',
          'appbar_title3': '자료',
          'favorites': '즐겨찾기',
        },
        'en_US': {
          'appbar_title1': 'phrases',
          'appbar_title2': 'words',
          'appbar_title3': 'document',
          'favorites': 'favorites',
        },
        'ja_JP': {
          'appbar_title1': '文章',
          'appbar_title2': '単語',
          'appbar_title3': '資料',
          'favorites': 'お気に入り',
        },
        'zh_CN': {
          'appbar_title1': '句子',
          'appbar_title2': '词',
          'appbar_title3': '材料',
          'favorites': '收藏夹',
        },
      };
}
