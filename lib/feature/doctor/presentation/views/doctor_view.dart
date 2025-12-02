import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Utils/App-colors.dart';
import 'package:diiabest/core/Widgets/custom_btn.dart';
import 'package:diiabest/core/Widgets/custom_text_field.dart';
import 'package:diiabest/feature/doctor/cubit/doctor_cubit.dart';
import 'package:diiabest/feature/doctor/presentation/views/profile_doctor.dart';
import 'package:diiabest/feature/doctor/presentation/widgets/checked_container.dart';
import 'package:diiabest/feature/doctor/presentation/widgets/doctor_adresses.dart';
import 'package:diiabest/feature/doctor/presentation/widgets/time_work.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubit(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffE3F2FD), Color(0xffBBDEFB)], // Light to deep blue
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const DoctorViewBody(),
        ),
      ),
    );
  }
}

class DoctorViewBody extends StatelessWidget {
  const DoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
    );
    final double width = 1.sw;
    final double height = 1.sh;
    return Form(
      key: BlocProvider.of<DoctorCubit>(context).formKey,
      child: BlocListener<DoctorCubit, DoctorState>(
        listener: (context, state) {
          if (state is RegisterDoctorSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileDoctorView(),
              ),
                  (route) => false,
            );
          } else if (state is RegisterDoctorFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          } else if (state is GetProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
            ));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: height * 0.04),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      AppStrings.registernow,
                      style: CustomTextStyles.lohit500style24.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: height * 0.02),
                ),
                SliverToBoxAdapter(child: DoctorAdress(text: AppStrings.specialization)),
                SliverToBoxAdapter(child: SizedBox(height: height * 0.01)),
                const SliverToBoxAdapter(child: CheckedContainer()),

                SliverToBoxAdapter(child: SizedBox(height: height * 0.02)),
                SliverToBoxAdapter(child: DoctorAdress(text: AppStrings.clinicaddress)),

                SliverToBoxAdapter(
                  child: _buildInputField(
                    context: context,
                    controller: BlocProvider.of<DoctorCubit>(context).citystreetblocknumber,
                    labelText: AppStrings.citystreetblocknumber,
                    icon: Icons.location_city_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter some text';
                      final RegExp regExp = RegExp(r'^[^/]+/[^/]+/[^/]+$');
                      if (!regExp.hasMatch(value)) return 'Your address format is incorrect';
                      return null;
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: _buildInputField(
                    context: context,
                    controller: BlocProvider.of<DoctorCubit>(context).phoneNumbe,
                    labelText: AppStrings.phoneNumbe,
                    icon: Icons.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter some text';
                      if (value.length != 11) return "Your phone number is incorrect";
                      return null;
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: _buildInputField(
                    context: context,
                    controller: BlocProvider.of<DoctorCubit>(context).facebook,
                    labelText: "Link Of Facebook",
                    icon: Icons.facebook,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter some text';
                      return null;
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: _buildInputField(
                    context: context,
                    controller: BlocProvider.of<DoctorCubit>(context).whatsApp,
                    labelText: "Link Of WhatsApp",
                    icon: Icons.chat,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter some text';
                      return null;
                    },
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: height * 0.02)),
                SliverToBoxAdapter(child: DoctorAdress(text: AppStrings.timework)),
                SliverToBoxAdapter(child: SizedBox(height: height * 0.01)),

                const SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TimeWork(date: AppStrings.start, isStartTime: true),
                      TimeWork(date: AppStrings.end, isStartTime: false),
                    ],
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: height * 0.06)),

                SliverToBoxAdapter(
                  child: _buildSaveButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 📌 Custom Input Field with Modern Design
  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          prefixIcon: Icon(icon, color: Colors.blue.shade700),
          hintText: labelText,
          errorStyle: TextStyle(fontSize: 14.sp),
          hintStyle:  TextStyle(color: Colors.blueGrey,fontSize: 14.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 📌 Modern Save Profile Button
  Widget _buildSaveButton(BuildContext context) {
    return CustomBtn(
      text: AppStrings.saveprofile,
      onPressed: () {
        var formKey = BlocProvider.of<DoctorCubit>(context).formKey;
        if (formKey.currentState!.validate()) {
          BlocProvider.of<DoctorCubit>(context).registerDoctor();
        }
      },
    );
  }
}
