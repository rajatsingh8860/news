import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/application/home/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelectionBottomSheet extends StatelessWidget {
  const CategorySelectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        context.read<HomeCubit>().setBottomSheetParameter(false);
      },
      builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Container(
                height: 390.h,
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
                            "Filter by category",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<HomeCubit>()
                                    .setCategorySelectionBottomSheet(false);
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                    ),
                    const Divider(),

                    //0
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().setCategoryName("");
                        context.read<HomeCubit>().setCategoryFilter(true);
                        context
                            .read<HomeCubit>()
                            .setCategorySelectionBottomSheet(false);
                        context.read<HomeCubit>().resetPageNo();
                        context.read<HomeCubit>().getNewsFeedback();
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("All categories"),
                      trailing: (state.categoryName == "")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //1
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().setCategoryName("business");
                        context.read<HomeCubit>().setCategoryFilter(true);
                        context.read<HomeCubit>().resetPageNo();
                        context
                            .read<HomeCubit>()
                            .setCategorySelectionBottomSheet(false);
                        context.read<HomeCubit>().getNewsFeedback();
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("Business"),
                      trailing: (state.categoryName == "business")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //2
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().setCategoryName("technology");
                        context.read<HomeCubit>().setCategoryFilter(true);
                        context.read<HomeCubit>().resetPageNo();
                        context
                            .read<HomeCubit>()
                            .setCategorySelectionBottomSheet(false);
                        context.read<HomeCubit>().getNewsFeedback();
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("Technology"),
                      trailing: (state.categoryName == "technology")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //3
                    ListTile(
                      onTap: () {
                        context
                            .read<HomeCubit>()
                            .setCategoryName("entertainment");
                        context.read<HomeCubit>().setCategoryFilter(true);
                        context.read<HomeCubit>().resetPageNo();
                        context
                            .read<HomeCubit>()
                            .setCategorySelectionBottomSheet(false);
                        context.read<HomeCubit>().getNewsFeedback();
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("Entertainment"),
                      trailing: (state.categoryName == "entertainment")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //4
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().setCategoryName("general");
                        context.read<HomeCubit>().setCategoryFilter(true);
                        context.read<HomeCubit>().resetPageNo();
                        context
                            .read<HomeCubit>()
                            .setCategorySelectionBottomSheet(false);
                        context.read<HomeCubit>().getNewsFeedback();
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("General"),
                      trailing: (state.categoryName == "general")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //5
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().setCategoryName("health");
                        context.read<HomeCubit>().setCategoryFilter(true);
                        context.read<HomeCubit>().resetPageNo();
                        context
                            .read<HomeCubit>()
                            .setCategorySelectionBottomSheet(false);
                        context.read<HomeCubit>().getNewsFeedback();
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("Health"),
                      trailing: (state.categoryName == "health")
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
