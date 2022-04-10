import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/application/home/home_cubit.dart';
import 'package:news/domain/home/home_repo.dart';
import 'package:news/injection.dart';
import 'package:news/presentation/home/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<HomeCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home:  HomePage());
        },
      ),
    );
  }
}
