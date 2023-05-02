import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/res/fonts.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 22,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 40,
              color: AppColors.primaryTextTextColor,
              fontFamily: AppFonts.sfProDisplayRegular,
              fontWeight: FontWeight.w600,
              height: 1.6),
          displayMedium: TextStyle(
              fontSize: 32,
              color: AppColors.primaryTextTextColor,
              fontFamily: AppFonts.sfProDisplayRegular,
              fontWeight: FontWeight.w600,
              height: 1.6),
          displaySmall: TextStyle(
              fontSize: 28,
              color: AppColors.primaryTextTextColor,
              fontFamily: AppFonts.sfProDisplayRegular,
              fontWeight: FontWeight.w600,
              height: 1.8),
          bodyLarge: TextStyle(
              fontSize: 22,
              color: AppColors.primaryTextTextColor,
              fontFamily: AppFonts.sfProDisplayBold,
              fontWeight: FontWeight.w700,
              height: 1.8),
          bodyMedium: TextStyle(
              fontSize: 18,
              color: AppColors.primaryTextTextColor,
              fontFamily: AppFonts.sfProDisplayRegular,
              height: 1.8),
          bodySmall: TextStyle(
              fontSize: 12,
              color: AppColors.primaryTextTextColor,
              fontFamily: AppFonts.sfProDisplayBold,
              height: 2.26),
        ),
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}