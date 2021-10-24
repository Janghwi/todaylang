import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangText extends StatelessWidget {
  final String text;
  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names
  LangText(appbar_title1, {required this.text});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Text(text.tr);
  }
}
