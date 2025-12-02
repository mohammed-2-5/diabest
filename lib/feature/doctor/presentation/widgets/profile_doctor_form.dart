import 'package:cached_network_image/cached_network_image.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/feature/auth/auth_cubit/auth_cubit.dart';
import 'package:diiabest/feature/doctor/cubit/doctor_cubit.dart';
import 'package:diiabest/feature/doctor/presentation/views/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDoctorForm extends StatelessWidget {
  const ProfileDoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffE3F2FD), Color(0xffBBDEFB)], // Soft Blue Gradient
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 30.h),

                // 🌟 Profile Image with Shadow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 65.r,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65.r),
                      child: CachedNetworkImage(
                        imageUrl: BlocProvider.of<AuthCubit>(context).currentUser.profileImage,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, error, stackTrace) =>
                        const Icon(Icons.error, color: Colors.red, size: 50),
                        fit: BoxFit.cover,
                        width: 130.w,
                        height: 130.h,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // 🌟 Profile Information Cards
                _buildInfoCard(Icons.person, "Name", state.doctor.fullName),
                _buildInfoCard(Icons.medical_services, "Specialization", state.doctor.specialization),
                _buildInfoCard(Icons.phone, "Phone Number", state.doctor.phoneNumber),
                _buildInfoCard(Icons.location_on, "Address", state.doctor.clinicAddress, maxLines: 2),
                _buildInfoCard(Icons.mobile_friendly, "WhatsApp", state.doctor.whatsappLink),
                _buildInfoCard(Icons.facebook, "Facebook", state.doctor.facebookLink),

                SizedBox(height: 30.h),

                // 🌟 Modern Edit Profile Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileDoctor(),
                      ),
                    );
                  },
                  child: Container(
                    width: 180.w,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff42A5F5), Color(0xff1976D2)], // Vibrant Blue Gradient
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // 📌 Function to Build Profile Information Cards
  Widget _buildInfoCard(IconData icon, String title, String value, {int maxLines = 1}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 28.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyles.lohit500style20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: CustomTextStyles.lohit400style18.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
