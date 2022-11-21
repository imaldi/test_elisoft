part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginSuccess extends LoginState {
  final UserLoginResponse response;
  const LoginSuccess(this.response);
  @override
  List<Object> get props => [response];
}
class LoginFailed extends LoginState {
  final String errorMessage;

  const LoginFailed(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
