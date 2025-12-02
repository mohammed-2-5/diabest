import 'package:date_picker_timeline/extra/color.dart';
import 'package:diiabest/core/Utils/App-Assets.dart';
import 'package:diiabest/core/Utils/App-colors.dart';

import 'package:diiabest/feature/doctors_patient/cubit/doctor_patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/core/Utils/App-colors.dart';

import '../../../../models/doctor_model.dart';
import '../../../Eating/presentation/view/eating_view.dart';
import '../../../doctor/data/model/doctor_model.dart';
import '../../../doctors_patient/Presentation/view/description_of_doctor.dart';
import '../../../doctors_patient/Presentation/view/doctor_patient.dart';
import '../../../organs/presentation/view/organs_search.dart';
import '../../../reminder_medicins/presentation/view/reminder_medicin.dart';
import '../../../sports/presentation/Sports.dart';
import 'custom_list_tile.dart';

class CustomHome extends StatelessWidget {
  final List<Map<String, dynamic>> tiles = [
    {
      'title': 'Organs',
      'subtitle': 'New',
      'icon': Assets.imagesorgans,
      'color': Color(0xFF62C5DE),

      "iconColor": Colors.white,
      "screen": OrgansView(),
    },
    {
      'title': 'Reminder',
      'subtitle': 'New',
      'icon': Assets.imagesImagePill,
      'color': Color(0xFF4AA8D1),

      "screen": ReminderMedicinsView(),
    },
    {
      "iconColor": Colors.white,
      'title': 'Eating',
      'subtitle': 'New',
      'icon': Assets.imagesImageMeal,
      'color': Color(0xFF3C93C3),

      "screen": EatingView(),
    },
    {
      "iconColor": Colors.white,
      'title': 'Sports',
      'subtitle': 'New',
      'icon': Assets.imagesImageSports,
      'color': Color(0xFF3178B0),
      "onPressed": (BuildContext context) {
        // customNavigate(context, "/WorkoutPlanScreen");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SportsScreen()));
      },
      "screen": SportsScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Image.asset(
                    Assets.imagesLogo2,
                    width: 100.w,
                    height: 100.h,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Dia',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color:const Color(0xffDF1F24), // Deep Red
                                ),
                              ),
                              TextSpan(
                                text: 'Best',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: const Color(0xFF0C3D56), // Deep Blue
                                ),
                              ),
                            ],
                          ),
                        ),


                        Text(
                          'Enjoy your life with Diabest',
                          style: TextStyle(fontSize: 16.sp, color: const Color(0xFF0C3D56)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Grid Section
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: tiles.length,
                itemBuilder: (context, index) {
                  final tile = tiles[index];
                  return CustomListTileInHome(
                    iconColor: tile['iconColor'],
                    titlehome: tile['title'],
                    subtitlehome: tile['subtitle'],
                    leadinghome: tile['icon'],
                    backgroundColor: tile['color'],
                    onpressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => tile['screen'],));
                    },
                  );
                },
              ),

              SizedBox(height: 20.h),

              // Doctors Section
              BlocProvider(
                create: (context) => DoctorPatientCubit()..getAllDoctor(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Doctors",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DoctorPatientView(),
                                ),
                              );
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Doctor List
                    BlocBuilder<DoctorPatientCubit, DoctorPatientState>(
                      builder: (context, state) {
                        if (state is DoctorPatientInitial) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GetAllDoctorSuccess) {
                          return SizedBox(
                            height: 230, // Adjusted height to fit the card
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.doctors.length > 6
                                  ? 6
                                  : state.doctors.length,
                              itemBuilder: (context, index) {
                                final doctor = state.doctors[index];
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DescriptionsOfDoctor(
                                                    doctor: doctor),
                                          ));
                                    },
                                    child: DoctorCard(doctor: doctor));
                              },
                            ),
                          );
                        } else if (state is GetAllDoctorFailure) {
                          return Center(
                            child: Text(
                              'Failed to load doctors',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
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

class DoctorCard extends StatelessWidget {
  final DoctorsModel doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Doctor Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              BlocProvider.of<DoctorPatientCubit>(context)
                  .getDoctorImage(specialization: doctor.specialization),
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 8),

          // Doctor Name
          Text(
            doctor.fullName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // Specialization
          Text(
            doctor.specialization,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          SizedBox(height: 4),

          // Availability (Start Time - End Time)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, color: Colors.blue, size: 16),
              SizedBox(width: 4),
              Text(
                "${doctor.startTime} - ${doctor.endTime}",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
