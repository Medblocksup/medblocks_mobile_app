import 'package:medical_app/presentation/state_holders/bottom_nav_controller.dart';
import 'package:medical_app/presentation/state_holders/wishlist_controller.dart';
import 'package:medical_app/presentation/ui/widgets/product_card.dart';
import 'package:medical_app/presentation/ui/widgets/shimmer_effect/shimmer_product_list_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/app_colors.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<WishlistController>().getWishList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Get.find<BottomNavController>().changeIndex(0);
      },
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Wishlist',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff1E293B),
            fontFamily: 'mn',
          ),
        ),
      ),
          body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<WishlistController>(
        builder: (controller) {

          if (controller.inProgress) {
            return const ShimmerProductListGridView();
          }

          if (controller.wishlistProductModel.data == null ||
              controller.wishlistProductModel.data!.isEmpty) {

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.favorite_border_rounded,
                    size: 90,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Your Wishlist is Empty",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: "mn",
                      color: Color(0xff1E293B),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Save your favourite medicines\nand products here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      fontFamily: "mn",
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton.icon(
                    onPressed: () {
                      Get.find<BottomNavController>().changeIndex(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Browse Products",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "mn",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            itemCount: controller.wishlistProductModel.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .54,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) {
              return ProductCard(
                productModel:
                controller.wishlistProductModel.data![index].product!,
                isWishProduct: true,
              );
            },
          );
        },
      ),
    ),
      ),
    );
  }
}
