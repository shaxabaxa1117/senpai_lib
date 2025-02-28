import 'package:flutter/material.dart';
import 'package:senpai_lib/config/theme/main_theme.dart';
import 'package:senpai_lib/injection_container.dart';
import 'package:senpai_lib/presentation/home_page.dart';

void main() async{
  await initializeDependecies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: mainTheme,
      home: HomePage(),
    );
  }
}

