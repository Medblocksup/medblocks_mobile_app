import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isAll;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onTap,
    required this.isAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
                letterSpacing: -0.3,
                fontFamily: 'mn',
              ),
            ),
          ),

          if (!isAll)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'mn',
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}