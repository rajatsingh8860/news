import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsTile extends StatelessWidget {
  const NewsTile(
      {Key? key,
      required this.title,
      required this.urlToImage,
      required this.newsSource})
      : super(key: key);

  final String title;
  final String urlToImage;
  final String newsSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 210.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsSource,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: title.length < 80
                            ? Text(
                                title,
                                style: TextStyle(fontSize: 14.sp),
                              )
                            : Text(
                                "${title.substring(0, 80)}...",
                                style: TextStyle(fontSize: 14.sp),
                              )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 140.h,
                  width: 100.h,
                  child: Image.network(
                    urlToImage,
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
