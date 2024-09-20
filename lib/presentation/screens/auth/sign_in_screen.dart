import 'dart:async';
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
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  bool _emailExists = false;
  String? _userRole;
  bool _showPasswordField = false;
  bool _isCodeFieldVisible = false;
  int _timerSeconds = 60;
  Timer? _timer;

  @override
  void dispose() {
    _emailController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // Email tekshirish funksiyasi
  Future<void> _checkEmailExists() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Emailni kiriting')),
      );
      return;
    }

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
            _showClientAlert();
          } else if (_emailExists && _userRole == 'doctor') {
            _showPasswordField = true;
          } else {
            _showConfirmationCodeDialog();
          }
        });
      } else {
        print('Xatolik yuz berdi: ${response.statusCode}');
      }
    } catch (e) {
      print('Xatolik yuz berdi: $e');
    }
  }

  // Tasdiqlash kodini kiritish oynasi
  void _showConfirmationCodeDialog() {
    setState(() {
      _isCodeFieldVisible = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tasdiqlash kodini kiriting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    InputDecoration(hintText: 'Tasdiqlash kodini kiriting'),
              ),
              SizedBox(height: 16),
              Text('$_timerSeconds soniya'),
              if (_timerSeconds == 0)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _timerSeconds = 60;
                      _startTimer();
                    });
                  },
                  child: Text('Qayta yuborish'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tasdiqlash'),
            ),
          ],
        );
      },
    );

    _startTimer();
  }

  // 60 soniyalik taymer funksiyasi
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  // Client uchun alert chiqish
  void _showClientAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ro\'yxatdan o\'tilgan'),
          content: Text(
              'Bu email mijoz sifatida ro\'yxatdan o\'tgan, boshqa emailni kiriting.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kirish ekrani')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Emailni kiriting'),
              onChanged: (value) {
                setState(() {
                  // Har qanday o'zgarishda parol va tasdiqlash kodini yashirish
                  _showPasswordField = false;
                  _isCodeFieldVisible = false;

                  // Tugmani holatini yangilash
                  _emailExists = false;
                  _timer?.cancel(); // Taymerni bekor qilish
                });
              },
            ),
            if (_showPasswordField)
              TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Parolni kiriting'),
              ),
            if (_isCodeFieldVisible)
              Column(
                children: [
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Tasdiqlash kodini kiriting'),
                  ),
                  SizedBox(height: 8),
                  Text('$_timerSeconds soniya'),
                ],
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkEmailExists,
              child: Text(_emailExists ? 'Kirish' : 'Ro\'yxatdan o\'tish'),
            ),
          ],
        ),
      ),
    );
  }
}

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   // final _passwordController = TextEditingController();

//   // Parol maydonini ko'rsatish kerakligini nazorat qilish
//   bool _showPassword = false;

//   bool _emailExists = true; // Email mavjudligini nazorat qilish
//   String? _userRole;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     // _passwordController.dispose();
//     super.dispose();
//   }

 

//   Future<void> _checkEmailExists() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       String email = _emailController.text;

//       try {
//         final response = await http.get(
//           Uri.parse('http://77.232.132.99:47608/check_email?email=$email'),
//         );
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           setState(() {
//             _emailExists = data['exists'];
//             _userRole = data['role'];
//             if (_emailExists && _userRole == 'client') {
//               // Client uchun xabar ko'rsatish
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content: Text(
//                         'Bu email allaqachon mijoz sifatida ro\'yxatdan o\'tgan')),
//               );
//             } else if (_emailExists && _userRole == 'doctor') {
//               _showPassword = true;
//               // Doctor uchun xabar ko'rsatish
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content: Text(
//                         'Bu email allaqachon doktor sifatida ro\'yxatdan o\'tgan')),
//               );
//             }
//           });
//         } else {
//           // Xatolikni qayta ishlash
//           print('Xatolik yuz berdi: ${response.statusCode}');
//         }
//       } catch (e) {
//         // Xatolikni qayta ishlash
//         print('Xatolik yuz berdi: $e');
//       }
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthSuccess) {
//           // Login successful, navigate to MainApp
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     MainApp(user: state.user, token: state.token)),
//           );
//         } else if (state is AuthFailure) {
//           // Login failed, show error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.error)),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Color(0xFFEDF2F7),
//           resizeToAvoidBottomInset: false,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: 'Emailni kiriting',
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             width: 0,
//                             color: Colors.white,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 0,
//                               color: Colors.white,
//                             ),
//                             borderRadius: BorderRadius.circular(8.0)),
//                         hintStyle: Theme.of(context)
//                             .textTheme
//                             .bodyMedium!
//                             .copyWith(color: Colors.grey),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide(
//                             width: 0,
//                             color: Colors.white,
//                           ),
//                         ),
//                         errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             width: 1.0,
//                             style: BorderStyle.solid,
//                             color: Colors.red,
//                           ),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Iltimos, emailingizni kiriting';
//                         }
//                         return null;
//                       },
//                       // onFieldSubmitted: (_) =>
//                       //     _checkEmailExists(), // Email tekshirishni ishga tushirish
//                     ),
//                     const SizedBox(height: 16.0),
//                     if (_showPassword)
//                       TextFormField(
//                         // controller: _passwordController,
//                         decoration: InputDecoration(
//                           hintText: _emailExists
//                               ? 'Tasdiqlash kodini kiriting'
//                               : 'Parolni kiriting',
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               width: 1.0,
//                               color: Colors.red,
//                             ),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                               borderRadius: BorderRadius.circular(8.0)),
//                           hintStyle: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                           ),
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return _emailExists
//                                 ? 'Iltimos, parolni kiriting'
//                                 : 'Iltimos, tasdiqlash kodini kiriting';
//                           }
//                           return null;
//                         },
//                       ),
//                     const SizedBox(height: 16.0),
//                     GestureDetector(
//                       onTap:
//                           _checkEmailExists, // Tugmani bosganda _handleButtonPress funksiyasini chaqirish,
//                       child: Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(
//                           vertical: 16.0,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         alignment: Alignment.center,
//                         child: state is AuthLoading
//                             ? CupertinoActivityIndicator(
//                                 color: Colors.white,
//                                 radius: 12.0,
//                               )
//                             : Text(
//                                 _emailExists ? 'Kirish' : 'Ro\'yxatdan o\'tish',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge!
//                                     .copyWith(color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



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