import 'package:flutter/material.dart';
import 'package:flutterhive_crud/Models/notes_model.dart';
import 'package:flutterhive_crud/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());

  await Hive.openBox<NotesModel>('notes');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

