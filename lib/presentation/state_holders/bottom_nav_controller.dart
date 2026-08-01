import 'package:medical_app/presentation/state_holders/auth_controller.dart';
import 'package:medical_app/presentation/ui/screen/cart_screen.dart';
import 'package:medical_app/presentation/ui/screen/category_screen.dart';
import 'package:medical_app/presentation/ui/screen/doctor_appointment_screen.dart';
import 'package:medical_app/presentation/ui/screen/home_screen.dart';
import 'package:medical_app/presentation/ui/screen/profile_screen.dart';
import 'package:medical_app/presentation/ui/screen/scanner_screen.dart';
import 'package:medical_app/presentation/ui/screen/wishlist_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    ScannerScreen(isQrCode: true),
    DoctorListScreen(),
    WishListScreen(),
    ProfileScreen()
  ];

  changeIndex(value) {
    if (value == 3 || value == 4) {
      if (Get.find<AuthController>().isTokenNotNull) {
        selectedIndex = value;
        update();
      } else {
        AuthController.goToLogIn();
      }
    } else {
      selectedIndex = value;
      update();
    }
  }
}
