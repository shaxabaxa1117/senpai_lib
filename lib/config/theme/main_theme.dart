
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
        // Основные цвета
        primaryColor: Color(0xFFC2185B), // Красный акцент
        // scaffoldBackgroundColor: Color.fromARGB(255, 186, 38, 92), // Светлый фон экрана
        colorScheme: ColorScheme(
          primary: Color(0xFFC2185B), // Красный
          secondary: Color(0xFF1A1A1A), // Фиолетовый
          surface: Color(0xFFFFFFFF), // Светлый фон
          error: Colors.redAccent,
          onPrimary: Colors.white, // Текст на красном
          onSecondary: Colors.white, // Текст на фиолетовом
          onSurface: Color(0xFF1A1A1A), // Текст на светлом фоне
          onError: Colors.white,
          brightness: Brightness.light, // Светлая тема
        ),

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent, // Прозрачный для градиента
          elevation: 0, // Без тени
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white), // Белые иконки
        ),

        // Карточки
        cardTheme: CardTheme(
          color: Color.fromARGB(255, 207, 31, 143), // Белый фон
          elevation: 4, // Лёгкая тень
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Закругление
          ),
        ),

        // Кнопки
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Прозрачный для градиента
            foregroundColor: Colors.white, // Текст/иконки белые
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        // Текст
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A), // Чёрный для заголовков
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Color(0xFF1A1A1A), // Основной текст
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            color: Colors.grey[600], // Второстепенный текст
          ),
          labelLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.white, // Текст кнопок
          ),
        ),

        // Чипы (жанры)
        chipTheme: ChipThemeData(
          backgroundColor: Color.fromARGB(255, 15, 9, 8).withOpacity(0.1), // Прозрачный красный
          labelStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 12,
            color: Color(0xFFC2185B), // Красный текст
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Иконки
        iconTheme: IconThemeData(
          color: Color(0xFF1A1A1A), // Чёрные иконки по умолчанию
        ),
      );