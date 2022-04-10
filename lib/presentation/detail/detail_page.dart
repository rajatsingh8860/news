import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.imageUrl,
      this.title,
      this.content,
      this.author,
      this.newsSource})
      : super(key: key);

  final imageUrl, title, content, author, newsSource;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool connected = true;

  @override
  void initState() {
    super.initState();
    checkConnection();
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
                      onPressed: () async {
                        await checkConnection();
                      },
                      child: const Text("Try again"))
                ],
              ),
            )
          : SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.h,
                      width: size.width,
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.newsSource,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Text(widget.content),
                    ),
                    InkWell(
                      onTap: () async {
                        await checkConnection();
                        if (connected) {
                          await launch(widget.author);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15.0, right: 15),
                        child: Row(
                          children: const [
                            Text(
                              "See full story ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff0C54BE),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Color(0xff0C54BE), size: 12)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
