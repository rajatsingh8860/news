import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/application/home/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryBottomSheet extends StatelessWidget {
  const CountryBottomSheet({Key? key}) : super(key: key);

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
                height: 250.h,
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
                            "Choose your location",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<HomeCubit>()
                                    .setBottomSheetParameter(false);
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                    ),
                    const Divider(),

                    //1
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().emptyListValue();
                        context.read<HomeCubit>().setSort(false);

                        context.read<HomeCubit>().setFilterParameter('');
                        context.read<HomeCubit>().setCategoryName('');
                        context.read<HomeCubit>().setCountryName("India");
                        context.read<HomeCubit>().setCountryIso("in");
                        context.read<HomeCubit>().resetPageNo();
                        context.read<HomeCubit>().getNewsFeedback();
                        context
                            .read<HomeCubit>()
                            .setBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("India"),
                      trailing: (state.countryIso == "in")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //2
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().emptyListValue();
                        context.read<HomeCubit>().setSort(false);
                        context.read<HomeCubit>().setFilterParameter('');
                        context.read<HomeCubit>().setCategoryName('');
                        context.read<HomeCubit>().setCountryName("USA");
                        context.read<HomeCubit>().setCountryIso("us");
                        context.read<HomeCubit>().resetPageNo();
                        context.read<HomeCubit>().getNewsFeedback();
                        context
                            .read<HomeCubit>()
                            .setBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("USA"),
                      trailing: (state.countryIso == "us")
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    const Divider(),

                    //3
                    ListTile(
                      onTap: () {
                        context.read<HomeCubit>().emptyListValue();
                        context.read<HomeCubit>().setSort(false);
                        context.read<HomeCubit>().setFilterParameter('');
                        context.read<HomeCubit>().setCategoryName('');
                        context.read<HomeCubit>().setCountryName("Sweden");
                        context.read<HomeCubit>().setCountryIso("se");
                        context.read<HomeCubit>().resetPageNo();
                        context.read<HomeCubit>().getNewsFeedback();
                        context
                            .read<HomeCubit>()
                            .setBottomSheetParameter(false);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading: const Text("Sweden"),
                      trailing: (state.countryIso == "se")
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
