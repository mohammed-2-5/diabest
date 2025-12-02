import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Widgets/custom_info_for_patient.dart';
import 'package:diiabest/core/Widgets/custom_text_field.dart';
import 'package:diiabest/feature/auth/auth_cubit/auth_cubit.dart';
import 'package:diiabest/feature/doctor/presentation/widgets/image_of_doctor.dart';
import 'package:diiabest/feature/profile/Presentation/view/edit_profile_password.dart';
import 'package:diiabest/feature/profile/Presentation/view/profile_view.dart';
import 'package:diiabest/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/patiant_model.dart';
import '../../../Register_your_information/cubit/register_patient_cubit.dart';

class CustomEditProfile extends StatefulWidget {
  const CustomEditProfile({super.key, required this.patient});
  final PatientModel patient;
  @override
  _CustomEditProfileState createState() => _CustomEditProfileState();
}

class _CustomEditProfileState extends State<CustomEditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.patient.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Profile Header
              Center(
                child: Column(
                  children: [
                    // Profile Image

                    const SizedBox(height: 10),
                    Text(
                      nameController.text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Patient Profile",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Profile Information Card
              Container(
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
                    // Full Name (Disabled)
                    CustomTextFormField1(
                      mycontroller: nameController,
                      labelText: "Full Name",
                      enable: true,
                      prefixIcon: Icon(Icons.person),
                    ),

                    const SizedBox(height: 10),

                    // Additional Patient Information
                    const CustomInfoForPatient(),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Buttons Section
              BlocListener<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileView()),
                          (route) => false,
                    );
                  } else if (state is UpdateProfileFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                child: Column(
                  children: [
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          profileCubit.fullName=nameController;
                          profileCubit.updateProfile();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF246BFE),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        AppStrings.saveprofile,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Change Password Button
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChangePasswordView()),
                        );
                      },
                      icon: const Icon(Icons.lock_outline, color: Colors.blue),
                      label: const Text(
                        AppStrings.changepassword,
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
