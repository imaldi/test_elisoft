import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_elisoft/data/models/user_login_response.dart';
import 'package:test_elisoft/ui/blocs/article_bloc/article_bloc.dart';

import '../cubits/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(FetchArticleEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(child: Builder(
            builder: (context) {
              var homeCubitState = context.watch<HomeCubit>().state;
              var userModel = homeCubitState.user;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, ${userModel.name.toString()}"
                  ),
                  BlocBuilder<ArticleBloc,ArticleState>(

                    builder: (c,s) {
                      var content = "No Articles";
                      if(s is ArticleSuccess){
                        content = s.articleResponse.articles?.map((e) => e.toJson())?.toString() ?? "Error";
                      }
                      print("Article Status: $s");
                      return s is ArticleLoading ?
                      CircularProgressIndicator()
                      : Text(
                      content
                    );
                    },
                  )
                ],
              );
            }
          ),),
        ),
      ),
    );
  }
}
