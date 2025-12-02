import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/core/Utils/App-colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "poppins",
          color: AppColors.primarycolor),
      titleMedium: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "poppins",
          color: AppColors.black1),
      titleSmall: TextStyle(
          fontSize: 7.sp,
          fontWeight: FontWeight.w400,
          fontFamily: "poppins",
          color: AppColors.black1),
      bodyMedium: TextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "poppins",
          color: AppColors.black1),
      bodySmall: TextStyle(
          fontSize: 6.5.sp,
          fontWeight: FontWeight.w400,
          fontFamily: "poppins",
          color: AppColors.black2),
    ),
    scaffoldBackgroundColor: AppColors.white,
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          theme: AppThemes.lightTheme,
          home: const CustomBtnNavigation(),
        );
      },
    );
  }
}

class CustomBtnNavigation extends StatelessWidget {
  const CustomBtnNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Diabest",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to Diabest!",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
