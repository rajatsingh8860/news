import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/application/home/home_cubit.dart';
import 'package:news/application/search/search_cubit.dart';
import 'package:news/data/home/model/home_model.dart';
import 'package:news/injection.dart';
import 'package:news/presentation/detail/detail_page.dart';
import 'package:news/presentation/home/widgets/news_tile.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0C54BE),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: BlocProvider(
        
        create: (context) => getIt<SearchCubit>(),

        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (searchContext, searchState) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                List<NewsModel> searchedNewsModel = state.newsModel
                    .where((p) => p.title!
                        .toLowerCase()
                        .contains(searchState.searchQuery.toLowerCase()))
                    .toList();

                int searchedNewsLength = searchedNewsModel.length;

                return SafeArea(
                  child: SizedBox(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: const Color(0xffCED3DC),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                            child: TextField(
                              onChanged: (val) {
                                context.read<SearchCubit>().setSearchQuery(val);
                              },
                              autofocus: true,
                              style: const TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.search),
                                hintText: "Search for news , topics..",
                              ),
                            ),
                          ),
                        ),
                      ),
                      (searchedNewsLength == 0)
                          ? Expanded(
                              child: SizedBox(
                                height: size.height * 0.80,
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/notFound.jpg",
                                      height: 100.h,
                                    ),
                                    const Text("No result found!")
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: searchedNewsLength,
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            CupertinoPageRoute(
                                                builder: (context) {
                                          return DetailPage(
                                             imageUrl: searchedNewsModel[i]
                                                .urlToImage!,
                                            title: searchedNewsModel[i].title!,
                                            content: searchedNewsModel[i]
                                                .description!,
                                            author:
                                                searchedNewsModel[i].author!,
                                            newsSource: searchedNewsModel[i]
                                                .newsSource!,
                                          );
                                        }));
                                      },
                                      child: NewsTile(
                                        title: searchedNewsModel[i].title!,
                                        urlToImage:
                                            searchedNewsModel[i].urlToImage!,
                                        newsSource:
                                            searchedNewsModel[i].newsSource!,
                                      ),
                                    );
                                  }))
                    ],
                  )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
