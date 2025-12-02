import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Utils/App-colors.dart';
import 'package:diiabest/feature/Register_your_information/cubit/register_patient_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Utils/App-colors.dart';
import 'package:diiabest/feature/Register_your_information/cubit/register_patient_cubit.dart';

class CustomHeightWeight extends StatelessWidget {
  const CustomHeightWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildProfileField(
            context,
            title: AppStrings.weight,
            controller: BlocProvider.of<RegisterPatientCubit>(context).weight,
            hint: AppStrings.enteryour,
            icon: Icons.fitness_center,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _buildProfileField(
            context,
            title: AppStrings.height,
            controller: BlocProvider.of<RegisterPatientCubit>(context).height,
            hint: AppStrings.enteryour,
            icon: Icons.height,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileField(BuildContext context,
      {required String title,
        required TextEditingController controller,
        required String hint,
        required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CustomTextStyles.lohit500style20,
        ),
        const SizedBox(height: 5),
        ProfileFormField(
          controller: controller,
          hint: hint,
          prefixIcon: icon,
        ),
      ],
    );
  }
}


class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    super.key,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.obscureText = false,
  });

  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background for clarity
        borderRadius: BorderRadius.circular(12.r), // Softer rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Light shadow for depth
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field is required";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: AppColors.primarycolor), // Medical blue icon
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primarycolor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ),
        style: TextStyle(fontSize: 16.sp, color: Colors.black87),
      ),
    );
  }
}

