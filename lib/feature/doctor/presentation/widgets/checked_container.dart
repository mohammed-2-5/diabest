import 'package:diiabest/core/Utils/App-Assets.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/feature/doctor/cubit/doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckedContainer extends StatefulWidget {
  const CheckedContainer({super.key});

  @override
  State<CheckedContainer> createState() => _CheckedContainerState();
}

class _CheckedContainerState extends State<CheckedContainer> {
  int selected = 0;

  Widget customRadio(String image, String title, int index) {
    bool isSelected = selected == index;

    return GestureDetector(
      onTap: () {
        BlocProvider.of<DoctorCubit>(context).seletSpecialization(index: index);
        setState(() {
          selected = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(12.w),
        width: 0.30.sw,
        height: 0.12.sh,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.blue.shade300 : Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(2, 3),
            ),
          ],
          border: isSelected
              ? Border.all(color: Colors.blue.shade800, width: 2)
              : Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 40.w,
            ),
            SizedBox(height: 5.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 10.w),
            customRadio(
              Assets.imagesImageInternist,
              AppStrings.internist,
              1,
            ),
            SizedBox(width: 8.w),
            customRadio(
              Assets.imagesImageCardiologist,
              AppStrings.cardiologist,
              2,
            ),
            SizedBox(width: 8.w),
            customRadio(
              Assets.imagesImageDermatolo,
              AppStrings.dermatology,
              3,
            ),
            SizedBox(width: 8.w),
            customRadio(
              Assets.imagesHepatologist,
              AppStrings.hepatologist,
              4,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
