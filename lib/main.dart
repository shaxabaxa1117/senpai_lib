import 'package:flutter/material.dart';
import 'package:senpai_lib/config/theme/main_theme.dart';
import 'package:senpai_lib/feature/anime/presentation/pages/anime_list_page.dart';
import 'package:senpai_lib/injection_container.dart';

void main() async{
   initializeDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mainTheme,
      home: AnimeListPage(),
    );
  }
}

