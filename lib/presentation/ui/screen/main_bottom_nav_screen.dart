import 'package:flutter/cupertino.dart';
import 'package:medical_app/presentation/state_holders/bottom_nav_controller.dart';
import 'package:medical_app/presentation/state_holders/brand_list_controller.dart';
import 'package:medical_app/presentation/state_holders/category_list_controller.dart';
import 'package:medical_app/presentation/state_holders/home_banner_controller.dart';
import 'package:medical_app/presentation/state_holders/new_product_controller.dart';
import 'package:medical_app/presentation/state_holders/popular_product_controller.dart';
import 'package:medical_app/presentation/state_holders/special_product_controller.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<HomeBannerController>().getBannerList();
      Get.find<CategoryListController>().getCategoryList();
      // Get.find<BrandListController>().getBrandList();
      Get.find<PopularProductController>().getPopularProductList();
      Get.find<NewProductController>().getNewProductList();
      Get.find<SpecialProductController>().getSpecialProductList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
        builder: (BottomNavController controller) {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(

              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.white,
              currentIndex: controller.selectedIndex,
              onTap: controller.changeIndex,

              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: const Color(0xff94A3B8),

              selectedFontSize: 12,
              unselectedFontSize: 12,

              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'mn',
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'mn',
              ),

              items: const [

                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner_outlined),
                  activeIcon: Icon(Icons.qr_code_scanner),
                  label: 'Scan',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  activeIcon: Icon(Icons.calendar_month),
                  label: 'Appointment',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded),
                  activeIcon: Icon(Icons.favorite_rounded),
                  label: 'Saved',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
        body: controller.screens[controller.selectedIndex],
      );
    });
  }
}
