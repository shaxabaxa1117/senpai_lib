import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:senpai_lib/feature/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:senpai_lib/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:senpai_lib/presentation/home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            // Фоновое изображение
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/background/sign_in.jpg"), // Укажите путь к изображению
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Контент с прокруткой (чтобы не перекрывалась клавиатурой)
            SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 10, color: Colors.black45, offset: Offset(2, 2))],
                        ),
                      ),
                      SizedBox(height: 30),
                      _buildTextField(_emailController, "Email", Icons.email),
                      SizedBox(height: 10),
                      _buildTextField(_passwordController, "Password", Icons.lock, obscureText: true),
                      SizedBox(height: 20),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is Authenticated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => HomePage()),
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return CircularProgressIndicator();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(SignInEvent(
                                    _emailController.text,
                                    _passwordController.text,
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.withOpacity(0.8),
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignUpPage()),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }

  /// Универсальный метод для создания текстовых полей
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
