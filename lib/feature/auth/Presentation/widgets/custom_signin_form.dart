import 'package:diiabest/core/Utils/App-Assets.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Widgets/custom_btn.dart';
import 'package:diiabest/core/Widgets/custom_text_field.dart';
import 'package:diiabest/feature/auth/Presentation/Views/sign_up.dart';
import 'package:diiabest/feature/auth/Presentation/widgets/custom_check_box.dart';
import 'package:diiabest/feature/auth/Presentation/widgets/custom_social_icons.dart';
import 'package:diiabest/feature/auth/Presentation/widgets/forgot_password_text_widget.dart';
import 'package:diiabest/feature/auth/Presentation/widgets/have_an_account_widget.dart';
import 'package:diiabest/feature/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSignInForm extends StatefulWidget {
  const CustomSignInForm({super.key});

  @override
  State<CustomSignInForm> createState() => _CustomSignInFormState();
}

class _CustomSignInFormState extends State<CustomSignInForm> {
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordObscure = true;
  bool isLoading = false;

  void _handleSignIn() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
      BlocProvider.of<AuthCubit>(context).loginWithEmailAndPassword(
        email: emailAddress.text,
        password: password.text,
      );

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.imagesLogo,
                      height:250.h,

                    ),

                    SizedBox(height: 10.h),

                    Text(
                      AppStrings.logintoyouraccount,
                      style: CustomTextStyles.lohit500style24.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // Modern Email Field
                    _buildTextField(
                      controller: emailAddress,
                      labelText: AppStrings.emailAddress,
                      icon: Icons.email,
                      isPassword: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 12.h),

                    // Modern Password Field
                    _buildTextField(
                      controller: password,
                      labelText: AppStrings.password,
                      icon: Icons.lock,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),
                    const CustomCheckBox(),
                    SizedBox(height: 15.h),
                    // Enhanced Sign In Button
                    GestureDetector(
                      onTap: isLoading ? null : _handleSignIn,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff4B79A1), Color(0xff283E51)], // Beautiful blue gradient
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child:  Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    const ForgotPasswordTextWidget(),

                    SizedBox(height: 18.h),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSocialIcons(image: Assets.imagesImageFacebook, url: ''),
                        SizedBox(width: 15.w),
                        CustomSocialIcons(image: Assets.imagesImageGoogle, url: ''),
                        SizedBox(width: 15.w),
                        CustomSocialIcons(image: Assets.imagesImageApple, url: ''),
                      ],
                    ),

                    SizedBox(height: 18.h),

                    HaveAnAccountWidget(
                      text1: AppStrings.donthaveanaccount,
                      text2: AppStrings.signUp,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpView()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required bool isPassword,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isPasswordObscure : false,
      validator: validator,

      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontSize: 12.sp,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade200, width: 1),
        ),
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey.shade600,
          ),
          onPressed: () {
            setState(() {
              isPasswordObscure = !isPasswordObscure;
            });
          },
        )
            : null,
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14.sp),
      ),
    );
  }
}
