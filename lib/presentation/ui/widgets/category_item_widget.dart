import 'package:medical_app/data/models/category_model.dart';
import 'package:medical_app/presentation/ui/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Get.to(
          ProductListScreen(
            categoryId: category.id?.toInt() ?? 0,
            category: category.categoryName,
          ),
        );
      },
      child: Container(
        width: 105,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 72,
              width: 90,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                // color: const Color(0xffF3F8FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(
                "https://medblocks.appsowk.org/${category.categoryImg}",
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.medication_outlined),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              category.categoryName ?? "Medicines",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff1E293B),
                height: 1.3,
                fontFamily: 'mn',
              ),
            ),
          ],
        ),
      ),
    );
  }
}