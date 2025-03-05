import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/config/theme/main_theme.dart';
import 'package:senpai_lib/core/constants/firebase_options.dart';
import 'package:senpai_lib/feature/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:senpai_lib/feature/auth/presentation/pages/auth_wrapper.dart';
import 'package:senpai_lib/injection_container.dart';
import 'package:senpai_lib/injection_container.dart' as di;

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
    return BlocProvider(
      create: (context) => di.sl.get<AuthBloc>()..add(CheckAuthEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: mainTheme,
        home: AuthWrapper(),
      ),
    );
  }
}
