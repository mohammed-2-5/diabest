import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/core/Utils/App-TextStyles.dart';
import 'package:diiabest/core/Utils/App-Assets.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF1F5F9)], // Light grey gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'Contact Us',
                      style: CustomTextStyles.lohit500style20.copyWith(
                        fontSize: 24.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Contact Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Assets.contat,
                      height: 200.h,
                      width: 280.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Help Text
                Text(
                  'If you need help,\nfeel free to contact us.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20.h),

                // Contact Options in GridView
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 1.2, // Adjust height ratio
                  ),
                  itemCount: contactItems.length,
                  itemBuilder: (context, index) {
                    return _buildContactOption(contactItems[index]);
                  },
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Contact Information Cards
  Widget _buildContactOption(ContactItem contact) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Light shadow
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            radius: 22.sp, // Adjust size
            child: Icon(
              contact.icon,
              color: Colors.blue[800],
              size: 26.sp,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            contact.title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (contact.subtitle != null)
            Text(
              contact.subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[700],
              ),
            ),
        ],
      ),
    );
  }
}

// Contact Information Data
class ContactItem {
  final IconData icon;
  final String title;
  final String? subtitle;

  ContactItem({required this.icon, required this.title, this.subtitle});
}

// List of Contact Items
final List<ContactItem> contactItems = [
  ContactItem(icon: Icons.alternate_email, title: 'Write to us', subtitle: 'diabest@gmail.com'),
  ContactItem(icon: Icons.help_outline, title: 'FAQs', subtitle: 'Common questions'),
  ContactItem(icon: Icons.phone, title: 'Call Us', subtitle: '01015290522'),
  ContactItem(icon: Icons.location_on, title: 'Visit Us', subtitle: 'Diabest Clinic'),
];
