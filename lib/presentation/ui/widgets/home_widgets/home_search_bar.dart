import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onVoiceTap;

  const HomeSearchBar({
    super.key,
    this.onTap,
    this.onVoiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: const Color(0xffEEF2F7),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: Colors.grey.shade500,
              size: 26,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                "Search medicines, vitamins...",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'mn',
                ),
              ),
            ),

            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 20,
                onPressed: onVoiceTap,
                icon: Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}