import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/application/home/home_cubit.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        context.read<HomeCubit>().setFilterBottomSheetParameter(false);
      },
      builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Container(
                height: 300.h,
                width: double.infinity,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Filter by source",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<HomeCubit>()
                                    .setFilterBottomSheetParameter(false);
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                    ),
                    const Divider(),

                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().setFilterParameter('');
                        context
                            .read<HomeCubit>()
                            .setFilterBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("All News Articles"),
                      trailing: (state.filterParameter == "")
                          ? const Icon(Icons.check)
                          : null,
                    ),

                    const Divider(),

                    //1
                    ListTile(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .setFilterParameter(state.newsModel[0].newsSource!);
                        context
                            .read<HomeCubit>()
                            .setFilterBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text(state.newsModel[0].newsSource!),
                      trailing: (state.filterParameter ==
                              state.newsModel[0].newsSource!)
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //2
                    ListTile(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .setFilterParameter(state.newsModel[1].newsSource!);
                        context
                            .read<HomeCubit>()
                            .setFilterBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text(state.newsModel[1].newsSource!),
                      trailing: (state.filterParameter ==
                              state.newsModel[1].newsSource!)
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //3
                    ListTile(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .setFilterParameter(state.newsModel[2].newsSource!);
                        context
                            .read<HomeCubit>()
                            .setFilterBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text(state.newsModel[2].newsSource!),
                      trailing: (state.filterParameter ==
                              state.newsModel[2].newsSource!)
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),
                  ],
                ));
          },
        );
      },
    );
  }
}
