
import 'package:diiabest/feature/Home/presentatio/widgets/custom_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../doctors_patient/cubit/doctor_patient_cubit.dart';
class HomeViews extends StatelessWidget {
  const HomeViews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorPatientCubit()..getAllDoctor(),
      child: Scaffold(
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child:CustomHome(),)
          )),
    ) ;
  }
}