import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:diiabest/feature/On-Boarding/presentation/views/on-boarding-view.dart';
import 'package:diiabest/feature/auth/Presentation/Views/sign_in.dart';
import 'package:diiabest/feature/auth/auth_cubit/auth_cubit.dart';
import 'package:diiabest/feature/auth/auth_cubit/autch_state.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content behind AppBar
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ShowOnBoard) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInView()),
            );
          } else if (state is UnShowOnBoard) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnBoardingView()),
            );
          }
        },
        child: Stack(
          children: [
            // Background Gradient - Light to Deep Blue
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffE3F2FD), // Light Blue
                    Color(0xffBBDEFB), // Medium Blue
                    Color(0xff64B5F6), // Deep Blue
                  ],
                ),
              ),
            ),

            // Glassmorphism Card
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Medical Illustration
                  Lottie.asset(
                    'Assets/lottie/Animation - 1740132347491.json', // Replace with a medical-themed Lottie animation
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 20.h),

                  // Title Text
                  Text(
                    "Choose Your Language",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900, // Deep Blue for Medical Look
                      shadows: [
                        Shadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Blue Gradient Buttons
                  _buildLanguageButton(
                    text: "العربية",
                    onTap: () => BlocProvider.of<AuthCubit>(context).checkShowOnBoard(),
                    gradientColors: [Colors.blue.shade300, Colors.blue.shade600], // Light to Deep Blue
                  ),
                  SizedBox(height: 15.h),
                  _buildLanguageButton(
                    text: "English",
                    onTap: () => BlocProvider.of<AuthCubit>(context).checkShowOnBoard(),
                    gradientColors: [Colors.blue.shade500, Colors.blue.shade900], // Deeper Blue Gradient
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String text,
    required VoidCallback onTap,
    required List<Color> gradientColors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200.w,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black26, blurRadius: 2)],
          ),
        ),
      ),
    );
  }
}
