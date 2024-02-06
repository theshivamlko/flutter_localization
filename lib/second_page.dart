import 'package:flutter/material.dart';
import 'package:flutter_localization/localization.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Second Page')),
        body: Column(
          children: [
            ...List.generate(
                LocalizationService.supportedLocales.length,
                (index) => GestureDetector(
                      onTap: () {
                        Locale newLocale = LocalizationService.supportedLocales[index];
                        LocalizationService.of(context)?.load(newLocale: newLocale);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          LocalizationService.supportedLocales[index].languageCode,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )),
            Text(
              LocalizationService.of(context)?.translate("secondPage") ?? "--",
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                LocalizationService.of(context)?.translate("goBack") ?? "--",
              ),
            ),
          ],
        ));
  }
}
