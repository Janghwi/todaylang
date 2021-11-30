import 'package:get/get.dart';

class LangController extends GetxController {
  // static LangController get to => Get.find();

  RxString setLang = 'kor'.obs;
  RxString setFlag = 'assets/images/usa.png'.obs;
  // var devLang = Get.deviceLocale;

  void engLoad(RxString setLang1) {
    setLang = setLang1;
    // update();
  }

  void flagLoad(RxString setFlag1) {
    setFlag = setFlag1;
    // update();
  }

  void langSet(String setLang) {
    var devLang = Get.deviceLocale;

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
  }
}
