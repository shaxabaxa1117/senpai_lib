import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senpai_lib/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:senpai_lib/features/auth/presentation/pages/sign_up_page.dart';
import 'package:senpai_lib/home/home_page.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          _navigateTo(context, HomePage());
        } else if (state is Unauthenticated) {
          _navigateTo(context, SignUpPage());
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return _buildLoadingScreen();
          }
          return state is Authenticated ? HomePage() : SignUpPage();
        },
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => page),
        (route) => false,
      );
    });
  }

  Widget _buildLoadingScreen() => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        // Фон с изображением в аниме-стиле
        image: DecorationImage(
          image: AssetImage(
            'assets/image/background/anime_loading.jpg',
          ), // Укажите путь к вашему изображению
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), // Затемнение для читаемости
            BlendMode.dstATop,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.withOpacity(0.7),
            Colors.pinkAccent.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кастомный индикатор загрузки
            Stack(
              alignment: Alignment.center,
              children: [
                // Внешний декоративный круг
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blueAccent.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                // Анимированный индикатор
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.cyanAccent,
                    ),
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Текст в аниме-стиле
            Text(
              'Preparing your journey...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily:
                    'AnimeFont', // Используйте кастомный шрифт, если есть (например, Anime Ace)
                shadows: [
                  Shadow(
                    color: Colors.pinkAccent,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
