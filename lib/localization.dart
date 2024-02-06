import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService? of(BuildContext context) {
    print("LocalizationService of $context");
    return Localizations.of<LocalizationService>(context, LocalizationService);
  }

  Map<String, String> _localizedStrings = {};

  Future<void> load() async {
    print("LocalizationService load lang/${locale.languageCode}.json");
    final jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, String>;
    jsonMap.forEach((key, value) {
      _localizedStrings[key] = value.toString();
    });
  }

  String? translate(String key) {
    print("LocalizationService translate $key");
    return _localizedStrings[key];
  }

  static const supportedLocales = [
    Locale("en", "US"),
    Locale("hi", "IN"),
    Locale("odi", "GB"),
  ];

  static Locale? localeResolutionCallback(Locale? locale, Iterable<Locale>? supportedLocales) {
    print(
        "LocalizationService localeResolutionCallback ${locale?.languageCode} ${supportedLocales?.map((e) => e.languageCode).toList()}");
    return supportedLocales!
        .firstWhere((element) => element.languageCode == locale!.languageCode, orElse: () => supportedLocales.first);
  }

  static const LocalizationsDelegate<LocalizationService> _delegate = _LocalizatioServiceDelegates();

  static const localizationDelegate = [
    GlobalMaterialLocalizations.delegate, // works on alert, ok, cancel translation
    GlobalWidgetsLocalizations.delegate, // RTL and LTR
    _delegate
  ];
}

class _LocalizatioServiceDelegates extends LocalizationsDelegate<LocalizationService> {
  const _LocalizatioServiceDelegates();
  @override
  bool isSupported(Locale locale) {
    print("_LocalizatioServiceDelegates isSupported ${locale.languageCode}");
    return LocalizationService.supportedLocales.contains(locale);
  }

  @override
  Future<LocalizationService> load(Locale locale) async {
    print("_LocalizatioServiceDelegates load ${locale.languageCode}");
    LocalizationService service = LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    print("_LocalizatioServiceDelegates shouldReload ${old.hashCode} ${this.hashCode} ${old != this}");
    // return old!=this;
    return false;
  }
}
