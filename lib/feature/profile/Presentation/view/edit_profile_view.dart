import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/feature/profile/Presentation/widget/custom_edit_profile.dart';
import 'package:diiabest/feature/profile/cubit/profile_cubit.dart';
import 'package:diiabest/models/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.patient,});
  final PatientModel patient;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            AppStrings.editprofile,
            style: CustomTextStyles.lohit500style22.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: EditProfileBody(patient:patient ),
      ),
    );
  }
}

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key, required this.patient});
  final PatientModel patient;
  @override
  Widget build(BuildContext context) {
    var profileCubit = BlocProvider.of<ProfileCubit>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Form(
          key: profileCubit.formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: CustomEditProfile(patient:patient),
          ),
        ),
      ),
    );
  }
}
