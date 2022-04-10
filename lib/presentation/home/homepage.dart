import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news/application/home/home_cubit.dart';
import 'package:news/data/home/model/home_model.dart';
import 'package:news/presentation/home/widgets/category_selection_bottom_sheet.dart';
import 'package:news/presentation/home/widgets/filter_bottom_sheet.dart';
import 'package:news/presentation/home/widgets/filter_selection_bottom_sheet.dart';
import 'package:news/presentation/detail/detail_page.dart';
import 'package:news/presentation/home/widgets/country_bottom_sheet.dart';
import 'package:news/presentation/home/widgets/news_tile.dart';
import 'package:news/presentation/search/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool connected = true;
  final scrollController = ScrollController();
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    checkConnection();
    setupController(context);
    context.read<HomeCubit>().getNewsFeedback();
  }

  checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setState(() {
        connected = true;
      });
    } else {
      setState(() {
        connected = false;
      });
    }
  }

  void setupController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<HomeCubit>().setCategoryFilter(false);
          context.read<HomeCubit>().getNewsFeedback();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<NewsModel> filteredNewsModel = state.newsModel
            .where((p) => p.newsSource!
                .toLowerCase()
                .contains(state.filterParameter.toLowerCase()))
            .toList();

        state.sortParameter == "publishedAt"
            ? filteredNewsModel
                .sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!))
            : filteredNewsModel;

        int filteredNewsLength = filteredNewsModel.length;

        return WillPopScope(
          onWillPop: state.showParentBottomSheet
              ? () async {
                  context.read<HomeCubit>().setParentBottomSheet(false);
                  return false;
                }
              : state.categorySelectionBottomSheet
                  ? () async {
                      context
                          .read<HomeCubit>()
                          .setCategorySelectionBottomSheet(false);
                      return false;
                    }
                  : state.showFilterBottomSheet
                      ? () async {
                          context
                              .read<HomeCubit>()
                              .setFilterBottomSheetParameter(false);
                          return false;
                        }
                      : state.showBottomSheet
                          ? () async {
                              context
                                  .read<HomeCubit>()
                                  .setBottomSheetParameter(false);

                              return false;
                            }
                          : () async {
                              SystemNavigator.pop();
                              return true;
                            },
          child: Scaffold(
              floatingActionButton: (state.showFilterBottomSheet ||
                      state.isLoading ||
                      state.showBottomSheet ||
                      state.showParentBottomSheet ||
                      !connected ||
                      state.endOfList ||
                      state.categorySelectionBottomSheet)
                  ? null
                  : FloatingActionButton(
                      onPressed: () {
                        context.read<HomeCubit>().setParentBottomSheet(true);
                      },
                      child: const FaIcon(FontAwesomeIcons.filter)),
              bottomSheet: state.showParentBottomSheet
                  ? const FilterSelectionBottomSheet()
                  : state.categorySelectionBottomSheet
                      ? const CategorySelectionBottomSheet()
                      : state.showFilterBottomSheet
                          ? const FilterBottomSheet()
                          : state.showBottomSheet
                              ? const CountryBottomSheet()
                              : null,
              backgroundColor: const Color(0xffF5F9FD),
              body: !connected
                  ? SizedBox(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                            "assets/internet.jpg",
                            width: size.width * 0.70,
                          )),
                          ElevatedButton(
                              onPressed: () {
                                checkConnection();
                                context.read<HomeCubit>().getNewsFeedback();
                              },
                              child: const Text("Try again"))
                        ],
                      ),
                    )
                  : (state.endOfList)
                      ? SizedBox(
                          height: size.height,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("No data found"),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        CupertinoPageRoute(builder: (context) {
                                      return HomePage();
                                    }));
                                  },
                                  child: const Text("Try again"))
                            ],
                          ),
                        )
                      : (state.isLoading && state.newsModel.isEmpty)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              height: size.height,
                              width: size.width,
                              child: Column(
                                children: [
                                  Container(
                                    color: const Color(0xff0C54BE),
                                    height: 100.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 40.0.h, left: 10.w),
                                          child: Text(
                                            "MyNews",
                                            style: TextStyle(
                                                fontSize: 21.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<HomeCubit>()
                                                .setBottomSheetParameter(true);
                                          },
                                          child: SafeArea(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20.0.h,
                                                  right: 20.w,
                                                  bottom: 2.h),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "LOCATION",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.sp),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        state.countryName,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.sp),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return const Search();
                                      }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        color: const Color(0xffCED3DC),
                                        height: 40.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                  "Search for news , topics.."),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Icon(Icons.search),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Top Headlines"),
                                        Row(
                                          children: [
                                            const Text("Sort :  "),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                hint: state.sortParameter ==
                                                        "publishedAt"
                                                    ? const Text("Newest")
                                                    : const Text("Popularity"),
                                                items: <String>[
                                                  "Newest",
                                                  "Popularity"
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  if (val == "Newest") {
                                                    context
                                                        .read<HomeCubit>()
                                                        .setSortParameter(
                                                            "publishedAt");
                                                  }
                                                  if (val == "Popularity") {
                                                    context
                                                        .read<HomeCubit>()
                                                        .setSortParameter(
                                                            "popularity");
                                                  }
                                                  context
                                                      .read<HomeCubit>()
                                                      .setFilterParameter('');
                                                  context
                                                      .read<HomeCubit>()
                                                      .setCategoryName('');
                                                  context
                                                      .read<HomeCubit>()
                                                      .setSort(true);
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          controller: scrollController,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              filteredNewsLength, //: filteredNewsLength,
                                          itemBuilder: (context, i) {
                                            if (i == state.newsModel.length &&
                                                state.pageNo != 1 &&
                                                state.endOfList) {
                                              return const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                        "No more data to load")),
                                              );
                                            } else if (i ==
                                                    state.newsModel.length -
                                                        1 &&
                                                state.pageNo != 1 &&
                                                i > 4 &&
                                                !state.endOfList) {
                                              return const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              );
                                            } else {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      CupertinoPageRoute(
                                                          builder: (context) {
                                                    return DetailPage(
                                                      imageUrl:
                                                          filteredNewsModel[i]
                                                              .urlToImage!,
                                                      title:
                                                          filteredNewsModel[i]
                                                              .title!,
                                                      content:
                                                          filteredNewsModel[i]
                                                              .description!,
                                                      author:
                                                          filteredNewsModel[i]
                                                              .author!,
                                                      newsSource:
                                                          filteredNewsModel[i]
                                                              .newsSource!,
                                                    );
                                                  }));
                                                },
                                                child: NewsTile(
                                                    title: filteredNewsModel[i]
                                                        .title!,
                                                    urlToImage:
                                                        filteredNewsModel[i]
                                                            .urlToImage!,
                                                    newsSource:
                                                        filteredNewsModel[i]
                                                            .newsSource!),
                                              );
                                            }
                                          }))
                                ],
                              ),
                            )),
        );
      },
    );
  }
}
