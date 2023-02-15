import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_bet/config/app_hive_boxes.dart';
import 'package:quiz_bet/config/app_router.dart';
import 'package:quiz_bet/config/app_bloc_observer.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(Duration(milliseconds: 500));


  ///SET BLOCK OBSERVER
  AppBlocObserver  appBlocObserver=AppBlocObserver();
  Bloc.observer = appBlocObserver;


  ///HIVE INIT
  await AppHiveBoxes.instance.initHiveBoxes();

  runApp(const MyApp());
}

//INIT ROUTERS
final AppRouter _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: true,
          initialRoute: AppRouterPaths.splashRoute,
          onGenerateRoute: _appRouter.generateRoute,
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);

            return MediaQuery(
              data: data.copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          color: AppColors.white,
          theme: AppTheme.theme,
        );
      }
    );
  }
}
