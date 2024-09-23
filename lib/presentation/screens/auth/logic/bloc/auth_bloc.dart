import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:health_link_admin/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final http.Client _httpClient;

  AuthBloc() : super(AuthInitial()) {
    // on<RegisterUserEvent>(_handleRegisterUserEvent);
    on<LoginUserEvent>(_handleLoginUserEvent);
  }

  Future<void> _handleLoginUserEvent(
      LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await http.post(
        Uri.parse('http://77.232.132.99:47608/login'),
        // Assuming your login endpoint is '/login' // Assuming your login endpoint is '/login'
        body: jsonEncode({
          'email': event.email,
          'password': event.password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        print('Token: $token');

        // Fetch user data (you might need a separate API call for this)
        final userResponse = await http.get(
          Uri.parse('http://77.232.132.99:47608/user'),
          // Assuming an endpoint to get user details
          headers: {'Authorization': 'Bearer $token'},
        );
        print(userResponse.body);
        print(userResponse.statusCode);

        if (userResponse.statusCode == 200) {
          final userData = jsonDecode(userResponse.body);
          final UserModel user = UserModel.fromJson(userData);

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print('Token: $token');

          // Convert UserModel to JSON string before storing
          final userJson = jsonEncode(user.toJson());
          await prefs.setString('user', userJson);
          print('User: $userJson');

          emit(AuthSuccess(user: user, token: token));
        } else {
          emit(AuthFailure('Foydalanuvchi ma\'lumotlarini olishda xatolik'));
        }
      } else {
        emit(AuthFailure('Noto\'g\'ri email yoki parol ${response.statusCode}'));
      }
    } catch (error) {
      emit(AuthFailure('Serverga ulanishda xatolik yuz berdi'));
      print(error.toString());
    }
  }

// Future<void> _handleRegisterUserEvent(
//     RegisterUserEvent event, Emitter<AuthState> emit) async {
//   emit(AuthLoading());
//
//   try {
//     final response = await http.post(
//       Uri.parse('http://77.232.132.99:47608/add/doctor'),
//       body: jsonEncode({
//         'first_name': event.firstName,
//         'last_name': event.lastName,
//         'email': event.email,
//         'password': event.password,
//       }),
//       headers: {'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // Backend javobini konsolga chiqarish
//       final responseData = jsonDecode(response.body);
//       print('Serverdan kelgan javob: $responseData');
//
//       final UserModel newUser = UserModel.fromJson(responseData['user']);
//
//       final token = responseData['token'];
//       print('Token: $token');
//       print(token);
//
//       if (token != null && token is String) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);
//         print('Token saqlandi: $token');
//
//         // Convert UserModel to JSON string before storing
//         final userJson = jsonEncode(newUser.toJson());
//         await prefs.setString('user', userJson);
//         print('User saqlandi: $userJson');
//
//         emit(AuthSuccess(user: newUser, token: token));
//       } else {
//         emit(AuthFailure('Token olishda xatolik yuz berdi'));
//       }
//     } else {
//       emit(AuthFailure('Xatolik yuz berdi: ${response.body}'));
//       print(response.statusCode);
//     }
//   } catch (e) {
//     emit(AuthFailure('Serverga ulanishda xatolik yuz berdi'));
//     print(e.toString());
//   }
// }
}
