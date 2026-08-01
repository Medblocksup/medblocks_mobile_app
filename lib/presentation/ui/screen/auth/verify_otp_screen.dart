import 'package:medical_app/presentation/state_holders/send_otp_controller.dart';
import 'package:medical_app/presentation/state_holders/time_decrease_controller.dart';
import 'package:medical_app/presentation/state_holders/verify_otp_controller.dart';
import 'package:medical_app/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:medical_app/presentation/ui/widgets/app_logo.dart';
import 'package:medical_app/presentation/ui/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'complete_profile_screen.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String email;

  const VerifyOTPScreen({super.key, required this.email});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TimeDecreaseController _timeDecreaseController =
      Get.find<TimeDecreaseController>();

  @override
  void initState() {
    _timeDecreaseController.decreaseSeconds(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GetBuilder<TimeDecreaseController>(
            builder: (TimeDecreaseController timerController) {
              return Form(
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
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: "mn",
                        color: Color(0xff1E293B),
                      ),
                    ),

                    const SizedBox(height: 8),

                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'mn',
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        children: [
                          const TextSpan(
                            text: "We've sent a verification code to\n",
                          ),
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    PinCodeTextField(
                      appContext: context,
                      controller: otpTEController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 250),
                      enableActiveFill: true,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'mn',
                      ),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(16),
                        fieldHeight: 58,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        activeColor: AppColors.primaryColor,
                        selectedColor: AppColors.primaryColor,
                        inactiveColor: Colors.grey.shade300,
                      ),
                    ),

                    const SizedBox(height: 30),

                    GetBuilder<VerifyOtpController>(
                      builder: (verifyController) {
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: verifyController.inProgress
                              ? const CenterCircularProgressIndicator()
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final bool response =
                                await verifyController.verifyOTP(
                                  widget.email,
                                  otpTEController.text,
                                );

                                if (response) {
                                  if (verifyController
                                      .shouldNavigateCompleteProfile) {
                                    Get.to(() =>
                                    const CompleteProfileScreen());
                                  } else {
                                    Get.offAll(() =>
                                    const MainBottomNavScreen());
                                  }
                                } else {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      title: 'OTP Verification Failed',
                                      message: verifyController.msg,
                                      backgroundColor: Colors.red,
                                      // colorText: Colors.white,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "Verify OTP",
                              style: TextStyle(
                                fontFamily: "mn",
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'mn',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          children: [
                            const TextSpan(
                              text: "Code expires in ",
                            ),
                            TextSpan(
                              text: "${timerController.currentSeconds}s",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Center(
                      child: TextButton(
                        onPressed: () async {
                          if (timerController.timeOver) {
                            final result =
                            await Get.find<SendOtpController>()
                                .sendOtp(widget.email);

                            if (result) {
                              Get.snackbar(
                                "OTP Resent",
                                "A new verification code has been sent.",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              Get.snackbar(
                                "Failed",
                                "Unable to resend OTP",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          }
                        },
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            color: timerController.timeOver
                                ? AppColors.primaryColor
                                : Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'mn',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    otpTEController.dispose();
    _timeDecreaseController.dispose(); // ONLY if you created it in this screen
    super.dispose();
  }
}
