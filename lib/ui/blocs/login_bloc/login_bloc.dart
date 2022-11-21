import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:test_elisoft/core/consts/urls.dart';

import '../../../data/models/user_login_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginToServerEvent>((event, emit) async {
      emit(LoginLoading());
      try{
        final response = await http.post(Uri.https(baseUrl,loginUrl),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: {
            'email': event.username,
            'password': event.password,
          },
        ).timeout(const Duration(seconds: 5), onTimeout: (){
          throw TimeoutException("Login Gagal");
        });

        if(response.statusCode == 200) {
          emit(LoginSuccess(UserLoginResponse.fromJson(jsonDecode(response.body))));
          return;
        }
        emit(LoginFailed("Server Error (code:${response.statusCode})"));

      } on TimeoutException {
        emit(const LoginFailed("TimeOut"));
      }

    });
  }
}
