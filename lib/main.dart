import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Provider/history_provider.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/UI/home_page.dart';
// import 'package:weather_app/UI/details_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FetchData()),
    ChangeNotifierProvider(create: (_) => HistoryProvider())
  ],
  child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
