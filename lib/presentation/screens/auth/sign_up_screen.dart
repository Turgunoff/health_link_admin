import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Bloc uchun import
import 'package:health_link_admin/presentation/screens/auth/logic/bloc/auth_bloc.dart';
import 'package:health_link_admin/presentation/screens/drawer/main_app.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // Formani tekshirish uchun kalit
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  //
  // Future<void> _registerUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //
  //     // 1. Controller'lardan ma'lumotlarni olish
  //     String lastName = _lastNameController.text;
  //     String firstName = _firstNameController.text;
  //     String email = _emailController.text;
  //     String password = _passwordController.text;
  //
  //     context.read<AuthBloc>().add(RegisterUserEvent(
  //           firstName: firstName,
  //           lastName: lastName,
  //           email: email,
  //           password: password,
  //           // ... boshqa ma'lumotlar
  //         ));
  //   }
  // }

  Future<void> _getTokenAndNavigate(
      BuildContext context, UserModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MainApp(user: user, token: token), // Tokenni uzatish
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Muvaffaqiyatli ro'yxatdan o'tish, foydalanuvchini MainAppScreen'ga o'ting va user obyektini uzating
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Muvaffaqiyatli ro\'yxatdan o\'tdingiz!')),
          );
          _getTokenAndNavigate(context, state.user, state.token);
        } else if (state is AuthFailure) {
          // Xatolik yuz berdi, foydalanuvchiga xabar bering
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: const Icon(
                  Iconsax.arrow_circle_left,
                  size: 36,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            hintText: 'Ismingizni kiriting',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
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
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Iltimos, familiyangizni kiriting';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Familiyangizni kiriting',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
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
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Iltimos, ismingizni kiriting';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Emailni kiriting',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
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
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1.0,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, emailingizni kiriting';
                      }
                      // Email formatini tekshirish uchun qo'shimcha validatsiya qo'shishingiz mumkin
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Iltimos, to\'g\'ri email kiriting';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Parolni kiriting',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
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
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1.0,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, parolni kiriting';
                      }
                      if (value.length < 6) {
                        return 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _registerUser();
                  //   },
                  //   child: state is AuthLoading
                  //       ? const CircularProgressIndicator()
                  //       : const Text('Ro\'yxatdan o\'tish'),
                  // ),
                  GestureDetector(
                    onTap: () {
                      // _registerUser();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: state is AuthLoading
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                              radius: 12.0,
                            )
                          : Text('Ro\'yxatdan o\'tish',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white)),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // const Text('Allaqachon akkauntingiz bormi?'),
                  // const Text.rich(
                  //   TextSpan(
                  //     text: 'Kirish',
                  //     style: TextStyle(
                  //         color: Colors.blue, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
