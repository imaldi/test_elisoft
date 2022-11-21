part of 'login_bloc.dart';



abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginToServerEvent extends LoginEvent{
  String username;
  String password;
  LoginToServerEvent(this.username,this.password);

  @override
  List<Object?> get props => [
    username,
    password
  ];
}
