import 'package:flutter/material.dart';
import 'package:weather_application/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home:const WeatherScreen(),
    );
  }
}