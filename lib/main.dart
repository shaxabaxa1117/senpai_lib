import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:senpai_lib/config/theme/main_theme.dart';
import 'package:senpai_lib/core/constants/firebase_options.dart';

import 'package:senpai_lib/injection_container.dart';
import 'package:senpai_lib/presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
