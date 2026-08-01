import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/presentation/state_holders/auth_controller.dart';
import 'package:medical_app/presentation/state_holders/read_profile_data_controller.dart';
import 'package:medical_app/presentation/ui/utility/utils.dart';

import '../../../data/models/create_profile_params.dart';
import '../../state_holders/complete_profile_controller.dart';
import '../utility/app_colors.dart';
import '../widgets/circular_progress_indicator.dart';
import 'auth/verify_email_screen.dart';
import 'main_bottom_nav_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final readProfileController = Get.find<ReadProfileDataController>();
  final authController = Get.find<AuthController>();



  final TextEditingController _cusNameTEController = TextEditingController();
  final TextEditingController _cusAddTEController = TextEditingController();
  final TextEditingController _cusCityEController = TextEditingController();
  final TextEditingController _cusStateTEController = TextEditingController();
  final TextEditingController _cusPostcodeTEController =
  TextEditingController();
  final TextEditingController _cusCountryTEController = TextEditingController();
  final TextEditingController _cusPhoneTEController = TextEditingController();
  final TextEditingController _cusFaxTEController = TextEditingController();
  final TextEditingController _shipNameTEController = TextEditingController();
  final TextEditingController _shipAddTEController = TextEditingController();
  final TextEditingController _shipCityTEController = TextEditingController();
  final TextEditingController _shipStateTEController = TextEditingController();
  final TextEditingController _shipPostcodeTEController =
  TextEditingController();
  final TextEditingController _shipCountryTEController =
  TextEditingController();
  final TextEditingController _shipPhoneTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    readProfileController.readProfileData(AuthController.token!);
    


    _cusNameTEController.text = readProfileController.profile.data?.cusName ?? "";
    _cusAddTEController.text = readProfileController.profile.data!.cusAdd!;
    _cusPhoneTEController.text = readProfileController.profile.data!.cusPhone!;
    _shipNameTEController.text = readProfileController.profile.data!.shipName!;
    _shipAddTEController.text = readProfileController.profile.data!.shipAdd!;
    _shipCityTEController.text = readProfileController.profile.data!.shipCity!;
    _shipStateTEController.text = readProfileController.profile.data!.shipState!;
    _shipPhoneTEController.text = readProfileController.profile.data!.shipPhone!;



    super.initState();
  }

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
          "Edit Profile",
          style: TextStyle(
            fontFamily: "mn",
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff1E293B),
          ),
        ),
      ),
      body: GetBuilder<ReadProfileDataController>(
        builder: (controller) {
          return Visibility(
            visible: controller.inProgress==false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [



                      const Text("Name:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      TextFormField(
                        textInputAction: TextInputAction.next,



                        decoration:  InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            fontFamily: 'mn',
                          ),
                          filled: true,

                          fillColor: Colors.white,

                          contentPadding:  EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                        controller: _cusNameTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Address:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration:  InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(
                            fontFamily: 'mn',
                          ),
                          filled: true,

                          fillColor: Colors.white,

                          contentPadding:  EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                        controller: _cusAddTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter your address';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Phone:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration:  InputDecoration(
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                            fontFamily: 'mn',
                          ),
                          filled: true,

                          fillColor: Colors.white,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                        controller: _cusPhoneTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter your phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text("Shipping auther name:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration:  InputDecoration(
                          hintText: 'Shipping author name',
                          hintStyle: TextStyle(
                            fontFamily: 'mn',
                          ),
                          filled: true,

                          fillColor: Colors.white,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                        controller: _shipNameTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter your Shipping author name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Shipping address:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Shipping Address',
                          hintStyle: TextStyle(
                            fontFamily: 'mn',
                          ),
                          filled: true,

                          fillColor: Colors.white,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                        controller: _shipAddTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter your shipping address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("City and state:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration:  InputDecoration(
                                hintText: 'City',
                                hintStyle: TextStyle(
                                  fontFamily: 'mn',
                                ),
                                filled: true,

                                fillColor: Colors.white,

                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 18,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1.4,
                                  ),
                                ),
                              ),
                              controller: _shipCityTEController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'enter your ship city';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration:  InputDecoration(
                                hintText: 'State',
                                hintStyle: TextStyle(
                                  fontFamily: 'mn',
                                ),
                                filled: true,

                                fillColor: Colors.white,

                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 18,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1.4,
                                  ),
                                ),
                              ),
                              controller: _shipStateTEController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'enter your ship state';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Shipping phone:",style: TextStyle(fontSize: 14,fontFamily: 'mn'),),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration:  InputDecoration(
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                            fontFamily: 'mn',
                          ),
                          filled: true,

                          fillColor: Colors.white,

                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.4,
                            ),
                          ),
                        ),
                        controller: _shipPhoneTEController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter your ship phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GetBuilder<CompleteProfileController>(builder: (controller) {
                        return SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(

                              elevation: 0,

                              backgroundColor: AppColors.primaryColor,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),

                            ),

                            onPressed: () async {

                              // Keep your existing update logic here

                            },

                            child: controller.inProgress
                                ? const CenterCircularProgressIndicator()
                                : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Icon(
                                  Icons.save_outlined,
                                  color: Colors.white,
                                ),

                                SizedBox(width: 10),

                                Text(
                                  "Save Changes",
                                  style: TextStyle(
                                    fontFamily: "mn",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      }),
                    const SizedBox(
                      height: 10,
                    ),

                  ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    _cusAddTEController.dispose();
    _cusCityEController.dispose();
    _cusCountryTEController.dispose();
    _cusFaxTEController.dispose();
    _cusNameTEController.dispose();
    _cusPhoneTEController.dispose();
    _cusPostcodeTEController.dispose();
    _cusStateTEController.dispose();
    _shipAddTEController.dispose();
    _shipCityTEController.dispose();
    _shipCountryTEController.dispose();
    _shipNameTEController.dispose();
    _shipPhoneTEController.dispose();
    _shipPostcodeTEController.dispose();
    _shipStateTEController.dispose();
    super.dispose();
  }
}
