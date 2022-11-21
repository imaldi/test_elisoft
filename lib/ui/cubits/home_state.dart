part of 'home_cubit.dart';

class HomeState extends Equatable {
  final User user;
  const HomeState(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [
    user
  ];
}
