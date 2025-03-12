import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.label, required this.icon, required this.obscureText, required this.darkMode});
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: darkMode? Colors.black : Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: darkMode? Colors.black : Colors.white70),
        prefixIcon: Icon(icon, color: darkMode? Colors.black : Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkMode? Colors.black : Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkMode? Colors.black : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

