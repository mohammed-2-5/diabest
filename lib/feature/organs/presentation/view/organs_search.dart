import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diiabest/feature/organs/presentation/widget/eyes_view.dart';
import 'package:diiabest/feature/organs/presentation/widget/foot_view.dart';
import 'package:diiabest/feature/organs/presentation/widget/skin_view.dart';
import 'package:diiabest/feature/organs/presentation/widget/teeth_view.dart';

class OrgansView extends StatefulWidget {
  const OrgansView({super.key});

  @override
  State<OrgansView> createState() => _OrgansViewState();
}

class _OrgansViewState extends State<OrgansView> {
  String searchQuery = '';
  int? selectedOrgan;

  final List<Map<String, dynamic>> organs = [
    {'title': 'Foot', 'value': 3, 'icon': Icons.directions_walk, 'color': Colors.orange, 'page': FootView()},
    {'title': 'Teeth', 'value': 1, 'icon': Icons.medical_services, 'color': Colors.blue, 'page': TeethView()},
    {'title': 'Skin', 'value': 2, 'icon': Icons.spa, 'color': Colors.green, 'page': SkinView()},
    {'title': 'Eyes', 'value': 6, 'icon': Icons.visibility, 'color': Colors.purple, 'page': EyesView()},
  ];

  List<Map<String, dynamic>> getFilteredItems() {
    return organs.where((item) {
      return item['title']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = getFilteredItems();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                Text(
                  "Select the affected Organ",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for an organ...',
                      hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
                      prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.h),

                // Organ Selection Cards
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      var item = filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOrgan = item['value'];
                          });
                          navigateToPage(item['page']);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: selectedOrgan == item['value']
                                ? item['color']!.withOpacity(0.2)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: selectedOrgan == item['value']
                                  ? item['color']!
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Circular Icon
                              Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: item['color'],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item['icon'],
                                  color: Colors.white,
                                  size: 24.sp,
                                ),
                              ),
                              SizedBox(width: 15.w),

                              // Text
                              Expanded(
                                child: Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              // Animated Radio Button
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedOrgan == item['value']
                                        ? item['color']!
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                  color: selectedOrgan == item['value']
                                      ? item['color']
                                      : Colors.transparent,
                                ),
                                child: selectedOrgan == item['value']
                                    ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
