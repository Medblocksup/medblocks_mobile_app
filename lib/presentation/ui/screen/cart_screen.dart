import 'package:medical_app/presentation/state_holders/bottom_nav_controller.dart';
import 'package:medical_app/presentation/state_holders/cart_list_controller.dart';
import 'package:medical_app/presentation/ui/screen/checkout_screen.dart';
import 'package:medical_app/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:medical_app/presentation/ui/widgets/cart_widgets/cart_items.dart';
import 'package:medical_app/presentation/ui/widgets/shimmer_effect/shimmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
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
            'Shopping Cart',
            style: TextStyle(
              fontFamily: 'mn',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xff1E293B),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => const MainBottomNavScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff1E293B),
            ),
          ),
        ),
        body: GetBuilder<CartListController>(builder: (controller) {
          if (controller.inProgress) {
            return const ShimmerListView();
          } else {
            return controller.cartListModel.cartItemList == null ||
                controller.cartListModel.cartItemList!.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 90,
                      color: Colors.grey.shade300,
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Your Cart is Empty",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'mn',
                        color: Color(0xff1E293B),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Looks like you haven't added any medicines or healthcare products yet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.grey.shade600,
                        fontFamily: 'mn',
                      ),
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: 220,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.offAll(() => const MainBottomNavScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
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
                            fontFamily: 'mn',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Column(
                    children: [
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        controller.cartListModel.cartItemList?.length ?? 0,
                    itemBuilder: (context, index) => CartProductItem(
                      cartItem: controller.cartListModel.cartItemList![index],
                    ),
                  ),
                ),
                totalPriceAndCheckOutSection(controller.totalPrice)
              ],
            );
          }
        }),
      ),
    );
  }

  Widget totalPriceAndCheckOutSection(RxDouble totalPrice) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 20,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontFamily: "mn",
                        ),
                      ),

                      const SizedBox(height: 4),

                      Obx(
                            () => Text(
                          "€ ${totalPrice.value.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: "mn",
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  width: 170,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const CheckoutScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.lock_outline,
                          size: 20,
                          color: Colors.white,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "mn",
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }}

// bornes de quantité dans le panier
