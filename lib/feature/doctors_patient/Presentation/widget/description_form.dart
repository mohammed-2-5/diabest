import 'package:diiabest/core/Utils/App-Assets.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Utils/App-colors.dart';
import 'package:diiabest/feature/auth/Presentation/widgets/custom_social_icons.dart';
import 'package:diiabest/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/doctor_patient_cubit.dart';

class DescriptionsForm extends StatelessWidget {
  const DescriptionsForm({super.key, required this.doctor});
  final DoctorsModel doctor;
  String getDoctorImage({required String specialization}) {
    {
      if (specialization == 'Internist') {
        return Assets.imagesImageInternist;
      } else if (specialization == 'Cardiologist') {
        return Assets.imagesImageCardiologist;
      } else if (specialization == 'Dermatology') {
        return Assets.imagesImageDermatolo;
      } else {
        return Assets.imagesHepatologist;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: height * 0.21,
          child: Image.asset(
           getDoctorImage(specialization: doctor.specialization),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: height * 0.06,
        ),
        Text(
          "Name: ${ doctor.fullName}",
          style: CustomTextStyles.lohit500style20,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "Specialization: ${doctor.specialization} ",
          // Applocalizations.of(context)!.translatetext("specialization"),
          style: CustomTextStyles.lohit500style20,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "Start Date: ${doctor.startTime} ",
          // Applocalizations.of(context)!.translatetext("specialization"),
          style: CustomTextStyles.lohit500style20,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "End Data: ${ doctor.endTime}",
          // Applocalizations.of(context)!.translatetext("specialization"),
          style: CustomTextStyles.lohit500style20,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "Phone Number: ${ doctor.phoneNumber}",
          // Applocalizations.of(context)!.translatetext("phoneNumbe"),
          style: CustomTextStyles.lohit500style20,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          children: [
            Text(
              "address: ",
              maxLines: 2,
//  Applocalizations.of(context)!.translatetext("clinicaddress")        ,
              style: CustomTextStyles.lohit500style20,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            SizedBox(
              width: 220,
              child: Text(
                doctor.clinicAddress,
                style: CustomTextStyles.lohit400style20.copyWith(color: AppColors.black2,),
                maxLines: 2,
              ),
            )
          ],
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "contact Now",
              //  Applocalizations.of(context)!.translatetext("contactnow"),
              style: CustomTextStyles.lohit500style20,
            ),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSocialIcons(
              image: Assets.imagesImageFacebook,
              url: doctor.facebookLink,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            CustomSocialIcons(
              image: Assets.imageswhatsapp,
              url: doctor.whatsappLink,
            ),
          ],
        ),
      ],
    );
  }
}
