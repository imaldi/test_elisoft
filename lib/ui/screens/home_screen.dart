import 'package:flutter/material.dart';
import 'package:test_elisoft/data/models/user_login_response.dart';

class HomeScreen extends StatelessWidget {
  final UserLoginResponse response;
  const HomeScreen(this.response,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(
        response.toString()
      ),),
    );
  }
}
