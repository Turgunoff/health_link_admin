import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_link_admin/model/user_model.dart';
import 'package:health_link_admin/screens/auth/logic/bloc/auth_bloc.dart';
import 'package:health_link_admin/screens/auth/sign_up_screen.dart';
import 'package:health_link_admin/screens/drawer/main_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String email = _emailController.text;
      String password = _passwordController.text;

      // Trigger the login event in the AuthBloc
      context
          .read<AuthBloc>()
          .add(LoginUserEvent(email: email, password: password));
    }
  }

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
          appBar: AppBar(
            title: const Text('Kirish'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, emailingizni kiriting';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Parol'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos, parolni kiriting';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: state is AuthLoading ? null : _loginUser,
                    child: state is AuthLoading
                        ? const CircularProgressIndicator()
                        : const Text('Kirish'),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Allaqachon akkauntingiz bormi?'),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to RegistrationScreen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text('Ro\'yxatdan o\'tish'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
