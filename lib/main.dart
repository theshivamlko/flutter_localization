import 'package:flutter/material.dart';
import 'package:flutter_localization/localization.dart';
import 'package:flutter_localization/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("MyApp  $context");
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: LocalizationService.supportedLocales,
      localizationsDelegates: LocalizationService.localizationDelegate,
      localeResolutionCallback: LocalizationService.localeResolutionCallback,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: LocalizationService.of(context)?.translate("demoHomePage") ?? "--"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePage  $context");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...List.generate(
                LocalizationService.supportedLocales.length,
                (index) => GestureDetector(
                      onTap: () {
                        Locale newLocale = LocalizationService.supportedLocales[index];
                        LocalizationService.of(context)?.load(newLocale: newLocale);
                        setState(() {});
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
              LocalizationService.of(context)?.translate("descriptionCount") ?? "--",
            ),
            Text(
              LocalizationService.of(context)?.translate("india") ?? "--",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
