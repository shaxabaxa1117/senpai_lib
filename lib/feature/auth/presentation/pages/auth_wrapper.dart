

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/feature/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:senpai_lib/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:senpai_lib/presentation/home_page.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>( //! проверка
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        } else if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SignUpPage()),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is Authenticated) {
            return HomePage();
          } else {
            return SignUpPage();
          }
        },
      ),
    );
  }
}