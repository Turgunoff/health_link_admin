import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_link_admin/data/models/user_model.dart';
import 'package:health_link_admin/presentation/screens/auth/logic/bloc/auth_bloc.dart';
import 'package:health_link_admin/presentation/screens/auth/sign_up_screen.dart';
import 'package:health_link_admin/presentation/screens/drawer/main_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  // Parol maydonini ko'rsatish kerakligini nazorat qilish
  bool _showPassword = false;

  bool _emailExists = true; // Email mavjudligini nazorat qilish
  String? _userRole;

  @override
  void dispose() {
    _emailController.dispose();
    // _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _loginUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     String email = _emailController.text;
  //     String password = _passwordController.text;

  //     // Trigger the login event in the AuthBloc
  //     context
  //         .read<AuthBloc>()
  //         .add(LoginUserEvent(email: email, password: password));
  //   }
  // }

  // Future<void> _loginUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     String email = _emailController.text;
  //     String passwordOrCode = _passwordController.text;

  //     if (_showPassword) {
  //       // Login with password
  //       context
  //           .read<AuthBloc>()
  //           .add(LoginUserEvent(email: email, password: passwordOrCode));
  //     } else {
  //       // Verify email with code
  //       // Bu qismni o'zingizning tasdiqlash kodi mantiqingizga moslashtiring
  //       print('Emailni tasdiqlash: $email, Kod: $passwordOrCode');
  //     }
  //   }
  // }

  Future<void> _checkEmailExists() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String email = _emailController.text;

      try {
        final response = await http.get(
          Uri.parse('http://77.232.132.99:47608/check_email?email=$email'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _emailExists = data['exists'];
            _userRole = data['role'];
            if (_emailExists && _userRole == 'client') {
              // Client uchun xabar ko'rsatish
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Bu email allaqachon mijoz sifatida ro\'yxatdan o\'tgan')),
              );
            } else if (_emailExists && _userRole == 'doctor') {
              _showPassword = true;
              // Doctor uchun xabar ko'rsatish
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Bu email allaqachon doktor sifatida ro\'yxatdan o\'tgan')),
              );
            }
          });
        } else {
          // Xatolikni qayta ishlash
          print('Xatolik yuz berdi: ${response.statusCode}');
        }
      } catch (e) {
        // Xatolikni qayta ishlash
        print('Xatolik yuz berdi: $e');
      }
    }
  }

  // Future<void> _handleButtonPress() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     String email = _emailController.text;
  //     String passwordOrCode = _passwordController.text;

  //     if (_emailExists) {
  //       // Login with password
  //       context
  //           .read<AuthBloc>()
  //           .add(LoginUserEvent(email: email, password: passwordOrCode));
  //     } else {
  //       // Ro'yxatdan o'tkazish (bu yerda siz o'zingizning ro'yxatdan o'tkazish logikasini amalga oshirishingiz kerak)
  //       // Masalan, tasdiqlash kodini yuborish yoki to'g'ridan-to'g'ri ro'yxatdan o'tkazish
  //       print('Ro\'yxatdan o\'tkazish: $email');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Login successful, navigate to MainApp
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainApp(user: state.user, token: state.token)),
          );
        } else if (state is AuthFailure) {
          // Login failed, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFEDF2F7),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Emailni kiriting',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(8.0)),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.white,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, emailingizni kiriting';
                        }
                        return null;
                      },
                      // onFieldSubmitted: (_) =>
                      //     _checkEmailExists(), // Email tekshirishni ishga tushirish
                    ),
                    const SizedBox(height: 16.0),
                    if (_showPassword)
                      TextFormField(
                        // controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: _emailExists
                              ? 'Tasdiqlash kodini kiriting'
                              : 'Parolni kiriting',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8.0)),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return _emailExists
                                ? 'Iltimos, parolni kiriting'
                                : 'Iltimos, tasdiqlash kodini kiriting';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap:
                          _checkEmailExists, // Tugmani bosganda _handleButtonPress funksiyasini chaqirish,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: state is AuthLoading
                            ? CupertinoActivityIndicator(
                                color: Colors.white,
                                radius: 12.0,
                              )
                            : Text(
                                _emailExists ? 'Kirish' : 'Ro\'yxatdan o\'tish',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
