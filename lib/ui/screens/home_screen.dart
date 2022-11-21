import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_elisoft/data/models/user_login_response.dart';
import 'package:test_elisoft/ui/blocs/article_bloc/article_bloc.dart';

import '../../data/models/article_response.dart';
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
          child: Center(
            child: Builder(builder: (context) {
              var homeCubitState = context.watch<HomeCubit>().state;
              var userModel = homeCubitState.user;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Welcome, ",style: TextStyle(fontSize: 24),),
                      Text("${userModel.name.toString()}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (c, s) {
                      var content = "No Articles";
                      if (s is ArticleSuccess) {
                        content = s.articleResponse.articles
                                ?.map((e) => e.toJson())
                                .toString() ??
                            "Error";
                      }
                      print("Article Status: $s");
                      return s is ArticleLoading
                              ? Center(
                                child: SizedBox(
                          height: 64,
                          width: 64,
                          child: CircularProgressIndicator()),
                              )
                              : s is ArticleSuccess
                                  ? Column(
                                    children: [
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: s.articleResponse.articles
                                                    ?.map((e) =>
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints(
                                                    maxWidth: 200,
                                                    maxHeight: 200
                                                  ),
                                                  child: Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                              e.user?.name ?? "Aldi",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                                                          Text(e.content ?? "Empty", softWrap: true,
                                                          maxLines: 8,
                                                            overflow: TextOverflow.ellipsis,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    )
                                                    .toList() ??
                                                [],
                                          ),
                                        ),
                                      SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child:

                                          ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: s.articleResponse.articles?.length ?? 0,
                                              itemBuilder: (c,i) {
                                                var e = s.articleResponse.articles?[i] ?? Article();
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Card(
                                                color:Colors.grey[200],
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.image,size: 64,color: Colors.blueAccent,),
                                                          Text(
                                                              e.user?.name ?? "Aldi"),
                                                        ],
                                                      ),
                                                      Text(e.content ?? "Empty", softWrap: true,
                                                        maxLines: 5,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                        Text((e.created != null && e.created?.date != null) ? DateFormat("dd MMMM yyyy, HH:mm:ss").format(e.created!.date!) : "-")
                                                      ],)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })

                                        ),
                                    ],
                                  )
                                  : Text("Failed")
                          //   Text(
                          //   content
                          // )
                          ;
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
