import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Widgets/custom_btn_profile.dart';
import 'package:diiabest/feature/profile/Presentation/view/edit_profile_view.dart';
import 'package:diiabest/feature/profile/cubit/profile_cubit.dart';
import '../../../../models/patiant_model.dart';
import '../../../auth/Presentation/Views/sign_in.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getPatientData(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SignOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInView(),
              ),
                  (route) => false, // Removes all previous screens, including bottom nav
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            actions: const [
              SignOutButton(),
            ],
            backgroundColor: Colors.lightBlueAccent,
            title: Text(
              "Patient Profile",
              style: CustomTextStyles.lohit500style20.copyWith(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is GetProfileSuccess) {
                PatientModel patient = state.user;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildProfileCard(patient),
                        const SizedBox(height: 20),
                        _buildHealthInfo(patient),
                        const SizedBox(height: 30),
                        CustomBtnProfile(
                          text: AppStrings.editprofile,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileView(patient: patient),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  // 📌 Profile Card with Personal Details
  Widget _buildProfileCard(PatientModel patient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            patient.name,
            style: CustomTextStyles.lohit500style20.copyWith(fontSize: 22, color: Colors.black87),
          ),
          const SizedBox(height: 5),
          Text(
            "${patient.age} years old",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 5),
          _buildInfoRow(Icons.fitness_center, 'Weight', "${patient.weight} kg"),
          _buildInfoRow(Icons.height, 'Height', "${patient.height} cm"),
          _buildInfoRow(Icons.favorite, 'Health Status', patient.status),
        ],
      ),
    );
  }

  // 📌 Health Information Section
  Widget _buildHealthInfo(PatientModel patient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Medical History"),
          _buildInfoRow(Icons.warning, 'Diabetic Coma', patient.diabeticComa),
          _buildInfoRow(Icons.smoking_rooms, 'Smoking', patient.somking),
          _buildInfoRow(Icons.family_restroom, 'Genetic Diabetes', patient.geneticDiabetes),
          _buildInfoRow(Icons.monitor_heart, 'Blood Pressure', patient.bloodPresure),
          _buildInfoRow(Icons.favorite, 'Heart Disease', patient.heartDisease),
          _buildInfoRow(Icons.local_bar, 'Alcohol Consumption', patient.alcohols),
          _buildInfoRow(Icons.healing, 'Pancreas Disease', patient.pancreasDisease),
          _buildInfoRow(Icons.pregnant_woman, 'Breastfeeding', patient.breastfeeding),
          _buildInfoRow(Icons.medication, 'Oral Contraceptives', patient.oralContraceptives),
        ],
      ),
    );
  }

  // 📌 Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: CustomTextStyles.lohit500style20.copyWith(
          fontSize: 18,
          color: Colors.blue[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 📌 Info Row with Icon
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Sign-Out Button with Correct Logout Logic
class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout, color: Colors.red),
      onPressed: () {
        BlocProvider.of<ProfileCubit>(context).signOut();
      },
    );
  }
}
