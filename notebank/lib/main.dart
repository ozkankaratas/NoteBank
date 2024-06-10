// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:notebank/models/note_database.dart';
import 'package:notebank/pages/notes_Page.dart';
import 'package:notebank/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  // Initialize note isar database
WidgetsFlutterBinding.ensureInitialized();
await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Not Sağlayıcısı
        ChangeNotifierProvider(create: (context)=> NoteDatabase()),

        // Tema Sağlayıcısı
        ChangeNotifierProvider(create: (context)=> ThemeProvider())
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
      debugShowCheckedModeBanner: false,
      home: notes_Page(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}