import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_elisoft/data/models/user_login_response.dart';

import '../cubits/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Builder(
        builder: (context) {
          var homeCubitState = context.watch<HomeCubit>().state;
          var userModel = homeCubitState.user;
          return Text(
            userModel.toJson().toString()
          );
        }
      ),),
    );
  }
}
