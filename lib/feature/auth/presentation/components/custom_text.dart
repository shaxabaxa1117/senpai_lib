import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;

  const CustomText(this.text, {this.fontSize = 25, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [const Color.fromARGB(255, 122, 78, 199), const Color.fromARGB(255, 69, 151, 218), Colors.cyan, Colors.greenAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Обязательно нужно указать, иначе градиент не будет работать
          shadows: [Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(2, 2))],
        ),
      ),
    );
  }
}
