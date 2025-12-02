import 'package:diiabest/core/Utils/App-Assets.dart';
import 'package:diiabest/core/Utils/App-String.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/feature/doctors_patient/Presentation/view/description_of_doctor.dart';
import 'package:diiabest/feature/doctors_patient/cubit/doctor_patient_cubit.dart';
import 'package:diiabest/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomPatientDoctorForm extends StatelessWidget {
  const CustomPatientDoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 Updated Search Bar with Blue Theme
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            controller:
            BlocProvider.of<DoctorPatientCubit>(context).searchController,
            decoration: InputDecoration(
              hintText: "Search for a doctor...",
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.blue.shade700,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
              filled: true,
              fillColor: Colors.blue.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2.0),
              ),
              contentPadding: EdgeInsets.all(10),
            ),
            onChanged: (value) {
              BlocProvider.of<DoctorPatientCubit>(context).searchDoctor();
            },
          ),
        ),

        SizedBox(height: 10.h),

        // 🔹 List of Doctors
        BlocBuilder<DoctorPatientCubit, DoctorPatientState>(
          builder: (context, state) {
            if (state is GetAllDoctorSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  itemCount: state.doctors.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CardPatientDoctorList(doctor: state.doctors[index]);
                  },
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

// 🔹 Doctor Card Widget (Updated UI)
class CardPatientDoctorList extends StatelessWidget {
  final DoctorsModel doctor;

  const CardPatientDoctorList({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => DescriptionsOfDoctor(doctor: doctor),));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                BlocProvider.of<DoctorPatientCubit>(context)
                    .getDoctorImage(specialization: doctor.specialization),
                width: 70.w,
                height: 70.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.w),

            // 🔹 Doctor Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.fullName,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    doctor.specialization,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 6.h),

                  // 🔹 Distance (Instead of Rating)
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade700, size: 16),
                      SizedBox(width: 4.w),
                      Text(
                        "${doctor.clinicAddress} ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}