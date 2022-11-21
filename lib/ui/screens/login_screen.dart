import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_elisoft/ui/cubits/home_cubit.dart';
import 'package:test_elisoft/ui/widgets/custom_text_field.dart';

import '../../data/models/user_login_response.dart';
import '../blocs/article_bloc/article_bloc.dart';
import '../blocs/login_bloc/login_bloc.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController =
      TextEditingController(text: "rachman.latif@gmail.com");
  final passwordController = TextEditingController(text: "testing");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("My APPS"),
                CustomTextField(
                  controller: usernameController,
                  labelText: "Username",
                ),
                CustomTextField(
                  controller: passwordController,
                  labelText: "Password",
                  obscureText: true,
                  suffixIcon: const Icon(Icons.remove_red_eye),
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (_) {
                                  return HomeCubit(
                                      state.response.user ?? User());
                                }),
                                BlocProvider(
                                  create: (context) => ArticleBloc(),
                                ),
                              ],
                              child: HomeScreen(),
                            );
                          },
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(LoginToServerEvent(
                                  usernameController.text,
                                  passwordController.text));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 64),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: (state is LoginLoading)
                                    ? const FittedBox(
                                        child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                    : const Center(
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
