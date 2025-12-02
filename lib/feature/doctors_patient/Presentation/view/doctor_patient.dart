import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/feature/doctors_patient/cubit/doctor_patient_cubit.dart';
import 'package:diiabest/feature/doctors_patient/Presentation/widget/card_doctor_patient.dart';

import '../widget/custom_patient-doctor_form.dart';

class DoctorPatientView extends StatelessWidget {
  const DoctorPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorPatientCubit()..getAllDoctor(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0.w),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: 20.h),
                ),
                SliverToBoxAdapter(
                  child: CustomPatientDoctorForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
