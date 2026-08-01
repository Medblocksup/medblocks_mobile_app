import 'package:medical_app/presentation/state_holders/send_otp_controller.dart';
import 'package:medical_app/presentation/ui/widgets/app_logo.dart';
import 'package:medical_app/presentation/ui/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/app_colors.dart';
import 'verify_otp_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: AppLogo(
                        height: 75,
                        width: 75,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "mn",
                    color: Color(0xff1E293B),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Sign in with your email to continue.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                    fontFamily: "mn",
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "mn",
                  ),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: 'mn',
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(
                      fontFamily: 'mn',
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.primaryColor,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
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
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    RegExp emailRegex = RegExp(
                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
                    );

                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 36),

                GetBuilder<SendOtpController>(
                  builder: (controller) {
                    return SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: controller.inProgress
                          ? const CenterCircularProgressIndicator()
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool result = await controller.sendOtp(
                              _emailController.text.trim(),
                            );

                            if (result) {
                              Get.to(
                                    () => VerifyOTPScreen(
                                  email: _emailController.text.trim(),
                                ),
                              );
                            } else {
                              Get.snackbar(
                                'Failed',
                                controller.message,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            fontFamily: "mn",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    "We'll send a verification code to your email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: 'mn',
                      fontSize: 13,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
