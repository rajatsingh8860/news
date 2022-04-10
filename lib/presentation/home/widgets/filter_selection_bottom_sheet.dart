import 'package:flutter/material.dart';
import 'package:news/application/home/home_cubit.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSelectionBottomSheet extends StatelessWidget {
  const FilterSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 150.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                context.read<HomeCubit>().setParentBottomSheet(false);
              },
              icon: const Icon(Icons.cancel)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  context.read<HomeCubit>().setParentBottomSheet(false);
                  context.read<HomeCubit>().setFilterBottomSheetParameter(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: size.height * 0.10,
                  width: size.width * 0.45,
                  child: const Center(
                      child: Text(
                    "Source",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<HomeCubit>().setParentBottomSheet(false);
                  context
                      .read<HomeCubit>()
                      .setCategorySelectionBottomSheet(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  height: size.height * 0.10,
                  width: size.width * 0.45,
                  child: const Center(
                      child: Text("Category",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
