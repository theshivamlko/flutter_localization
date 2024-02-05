import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService? of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService);
  }

  Map<String, String> _localizedStrings = {};

  Future<void> load() async {
    final jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString) as Map<String, String>;
    /* jsonMap.forEach((key, value) {
      _localizedStrings[key]=value.toString();
    });*/
  }

  String? translate(String key) {
    return _localizedStrings[key];
  }

  static const supportedLocales = [
    Locale("en", "US"),
    Locale("hi", "IN"),
    Locale("odi", "IN"),
  ];

  static Locale? localeResolutionCallback(
      Locale? locale, Iterable<Locale>? supportedLocales) {
   return supportedLocales
        !.firstWhere((element) => element.languageCode == locale!.languageCode
   ,orElse: ()=>supportedLocales.first);
  }

 static   LocalizationsDelegate<LocalizationService> _delegate=_LocalizatioServiceDelegates();

  static const localizationDelegate=[
    GlobalMaterialLocalizations.delegate, // works on alert, ok, cancel translation
    GlobalWidgetsLocalizations.delegate,// RTL and LTR
    _delegate


  ];
}


class _LocalizatioServiceDelegates extends LocalizationsDelegate<LocalizationService>{
  @override
  bool isSupported(Locale locale) {
    return LocalizationService.supportedLocales.contains(locale);
  }

  @override
  Future<LocalizationService> load(Locale locale) async{
    LocalizationService service=LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {

   // return old!=this;
    return false;
  }

}