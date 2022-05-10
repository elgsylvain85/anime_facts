import 'dart:html';

import 'package:anime_facts/ui/anime_list_view.dart';
import 'package:anime_facts/utilities/local_translations.dart';
import 'package:anime_facts/utilities/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

/* starting point */
void main() {
  runApp(GetMaterialApp(
    locale: Get.deviceLocale,
    fallbackLocale: const Locale("fr"),
    translations: LocalTranslations(),
    theme: ThemeData(scaffoldBackgroundColor: const Color(0xfff0f2f5)),
    title: Utility.appTitle,
    home: const AnimeListView(),
  ));
}
