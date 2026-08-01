import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/doctor_model.dart';

import '../utility/app_colors.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctor Details",
          style: TextStyle(
            fontFamily: 'mn',
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Color(0xff1E293B),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            Hero(
              tag: doctor,
              child: Container(
                height: 380,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(doctor.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontFamily: 'mn',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1E293B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    doctor.specialty,
                    style: const TextStyle(
                      fontFamily: 'mn',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      infoChip(
                        Icons.star_rounded,
                        Colors.amber,
                        doctor.rating.toString(),
                      ),

                      const SizedBox(width: 12),

                      infoChip(
                        Icons.workspace_premium_rounded,
                        Colors.blueGrey,
                        doctor.experience,
                      ),

                    ],
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "About Doctor",
                    style: TextStyle(
                      fontFamily: 'mn',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1E293B),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    doctor.about,
                    style: TextStyle(
                      fontFamily: 'mn',
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.grey.shade700,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calendar_month_rounded),
                label: const Text(
                  "Book Appointment",
                  style: TextStyle(
                    fontFamily: 'mn',
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Get.snackbar(
                    "Coming Soon",
                    "Doctor is not available!",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget infoChip(
      IconData icon,
      Color color,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color: color,
          ),

          const SizedBox(width: 8),

          Text(
            text,
            style: const TextStyle(
              fontFamily: 'mn',
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
}