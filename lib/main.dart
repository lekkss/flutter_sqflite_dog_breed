import 'package:flutter/material.dart';
import 'package:flutter_sqflite_dog_breed/model/dog.dart';
import 'package:flutter_sqflite_dog_breed/service/database_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService _databaseService = DatabaseService();

  // Future<List<Dog>> _getDogs() async {
  //   return await _databaseService.dogs();
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
