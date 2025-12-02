import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../models/doctor_model.dart';

class DescriptionsOfDoctor extends StatelessWidget {
  final DoctorsModel doctor;

  const DescriptionsOfDoctor({super.key, required this.doctor});

  String getDoctorImage({required String specialization}) {
    if (specialization == 'Internist') {
      return 'Assets/Images/Internist.jpg'; // Replace with your image path
    } else if (specialization == 'Cardiologist') {
      return 'Assets/Images/cardio.jpg';
    } else if (specialization == 'Dermatology') {
      return 'Assets/Images/Dermatology.jpg';
    } else {
      return 'Assets/Images/Internist.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. ${doctor.fullName}',style: TextStyle(
            fontSize: 20
        ),),
        backgroundColor: Colors.white,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Specialized Profile Image with Blur Effect and Full-Width
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [

                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                    // Foreground circle profile image
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset( getDoctorImage(specialization: doctor.specialization))
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Dr. ${doctor.fullName}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      doctor.specialization,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4AA8D1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Info Cards Section
              Column(
                children: [
                  _buildInfoCard(Icons.phone, 'Phone', doctor.phoneNumber),
                  _buildInfoCard(
                      Icons.access_time, 'Clinic Hours', '${doctor.startTime} - ${doctor.endTime}'),
                  _buildInfoCard(
                      Icons.location_on, 'Clinic Address', doctor.clinicAddress),
                ],
              ),

              const SizedBox(height: 16),
              // Social Media Links (Facebook and WhatsApp)
              Row(
                children: [
                  // WhatsApp Button (with custom image)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(doctor.whatsappLink),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // WhatsApp color
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Assets/Images/whatsapp.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "WhatsApp",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Facebook Button (with custom image)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _launchURL(doctor.facebookLink),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Facebook color
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Assets/Images/ImageFacebook.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Facebook",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
// Custom Card Widget for Doctor's Info
  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      color:Color(0xFF3C93C3),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 28),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
  void _launchURL(String url) {
    // Here you would launch the URL using a package like url_launcher.
    // Example: launch(url);
  }
}

