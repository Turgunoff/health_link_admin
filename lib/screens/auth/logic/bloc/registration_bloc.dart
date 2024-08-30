import 'dart:convert';
import 'package:health_link_admin/model/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
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
          // Muvaffaqiyatli ro'yxatdan o'tish
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final UserModel newUser = UserModel.fromJson(responseData);
          emit(RegistrationSuccess(newUser)); // user obyektini uzatish
          // Foydalanuvchini tizimga kirish ekraniga o'ting
        } else {
          emit(RegistrationFailure('Xatolik yuz berdi: ${response.body}'));
        }
      } catch (error) {
        emit(RegistrationFailure('Serverga ulanishda xatolik yuz berdi'));
      }
    });
  }
}
