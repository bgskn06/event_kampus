import 'package:event_kampus/home_page.dart';
import 'package:event_kampus/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final documentsDir = await getApplicationDocumentsDirectory();
  // Hive.init(documentsDir.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const home_page(),
    );
  }
}

