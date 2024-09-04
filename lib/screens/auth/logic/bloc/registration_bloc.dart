import 'dart:convert';
import 'package:health_link_admin/model/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  var logger = Logger();
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegistrationLoading());

      try {
        final response = await http.post(
          Uri.parse('http://54.93.198.137:3000/add/doctor'),
          body: jsonEncode({
            'first_name': event.firstName,
            'last_name': event.lastName,
            'email': event.email,
            'password': event.password,
            // ... boshqa ma'lumotlar
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Backend javobini konsolga chiqarish
          final responseData = jsonDecode(response.body);
          print('Serverdan kelgan javob: $responseData');

          final UserModel newUser = UserModel.fromJson(responseData);

          final token = responseData['token'];

          if (token != null && token is String) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
            print('Token saqlandi: $token');
            emit(RegistrationSuccess(newUser)); // user obyektini uzatish
          } else {
            emit(RegistrationFailure('Token olishda xatolik yuz berdi'));
          }
        } else {
          emit(RegistrationFailure('Xatolik yuz berdi: ${response.body}'));
          print(response.statusCode);
        }
      } catch (error) {
        emit(RegistrationFailure('Serverga ulanishda xatolik yuz berdi'));
        print(error.toString());
        logger.e(
          'RegistrationBloc error: ${error.toString()}',
          error: error,
        );
      }
    });
  }
}
