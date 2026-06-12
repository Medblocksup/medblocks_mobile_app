import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_app/presentation/ui/screen/account_screen.dart';

import '../../../data/models/profile.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/read_profile_data_controller.dart';
import 'auth/verify_email_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xffE8EEFF),
              child: Icon(
                Icons.person,
                size: 55,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            // Name
             Text(
              AuthController.profile?.data?.cusName ?? "",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Email
            Text(
              AuthController.profile?.data?.user?.email ?? "",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),


            const SizedBox(height: 40),

            _menuTile(
              icon: Icons.language,
              title: "Language",
              onTap: () {
                showLanguageDialog(context);
              },
            ),const SizedBox(height: 12),

            _menuTile(
              icon: Icons.edit_note,
              title: "Edit Profile",
              onTap: () async {
                if(AuthController.token ==  null){
                  Get.to(()=> const VerifyEmailScreen());
                }else{
                  await Get.find<ReadProfileDataController>().readProfileData(AuthController.token!);
                  Get.to(()=> const AccountScreen());
                }
              },
            ),
            const SizedBox(height: 12),

            _menuTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              onTap: () {},
            ),

            const SizedBox(height: 12),

            _menuTile(
              icon: Icons.support_agent_outlined,
              title: "Support",
              onTap: () {},
            ),

            const SizedBox(height: 12),

            _menuTile(
              icon: Icons.logout_rounded,
              title: "Logout",
              iconColor: Colors.orange,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text(
                      "Are you sure you want to logout?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await AuthController.clearAuthData();
                          Get.to(() => const VerifyEmailScreen());
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // _menuTile(
            //   icon: Icons.delete_outline,
            //   title: "Delete Account",
            //   iconColor: Colors.red,
            //   textColor: Colors.red,
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //         title: const Text("Delete Account"),
            //         content: const Text(
            //           "This action cannot be undone. Do you want to continue?",
            //         ),
            //         actions: [
            //           TextButton(
            //             onPressed: () => Navigator.pop(context),
            //             child: const Text("Cancel"),
            //           ),
            //           ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: Colors.red,
            //             ),
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //             child: const Text(
            //               "Delete",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  static Widget _menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.blue,
    Color textColor = Colors.black,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String selectedLanguage = "English";

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Select Language",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    value: "English",
                    groupValue: selectedLanguage,
                    title: const Text("🇬🇧 English"),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    value: "French",
                    groupValue: selectedLanguage,
                    title: const Text("🇫🇷 Français"),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save selected language here
                    Navigator.pop(context);
                  },
                  child: const Text("Apply"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}