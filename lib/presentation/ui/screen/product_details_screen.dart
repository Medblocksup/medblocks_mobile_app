import 'package:flutter/widgets.dart';
import 'package:medical_app/data/models/product_details_data.dart';
import 'package:medical_app/presentation/state_holders/add_to_cart_controller.dart';
import 'package:medical_app/presentation/state_holders/auth_controller.dart';
import 'package:medical_app/presentation/state_holders/product_details_controller.dart';
import 'package:medical_app/presentation/ui/screen/auth/verify_email_screen.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:medical_app/presentation/ui/utility/utils.dart';
import 'package:medical_app/presentation/ui/widgets/circular_progress_indicator.dart';
import 'package:medical_app/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:medical_app/presentation/ui/widgets/product_details/review_and_rating.dart';
import 'package:medical_app/presentation/ui/widgets/shimmer_effect/shimmer_product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import '../../state_holders/wishlist_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ValueNotifier<int> noOfCartItem = ValueNotifier(1);

  String? _selectedColor = "Red";

  String? _selectedSize = "X";

  @override
  void initState() {
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xff1E293B),
              ),
            ),
          ),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff1E293B),
            fontFamily: "mn",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: IconButton(
                onPressed: () async {
                  final bool result =
                  await Get.find<WishlistController>().addToWishList(widget.productId,context);

                },
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  size: 22,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<ProductDetailsController>(builder: (controller) {
        final data = controller.productDetailsModel.data;

        if (controller.inProgress) {
          return SimmerProductDetails();
        } else if (data!.isEmpty) {
          return const Center(
            child: Text('Didn\'t get data'),
          );
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.06),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: ProductImageCarouselWidget(
                        height: Get.height * .32,
                        urls: [
                          getImage(controller
                                  .productDetailsData.product!.image!) ??
                              '',
                          getImage(controller
                                  .productDetailsData.product!.image!) ??
                              '',
                          getImage(controller
                                  .productDetailsData.product!.image!) ??
                              '',
                        ],
                      ),
                    ),
                    productDetailsBody(controller.productDetailsData),
                  ],
                ),
              ),
            ),
            priceAndCartSection(
                controller.productDetailsData.product?.price ?? '0'),
          ],
        );
      }),
    );
  }

  Padding productDetailsBody(ProductDetailsDataModel productDetails) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1E293B),
                    fontFamily: "mn",
                    overflow: TextOverflow.clip
                  ),
                ),
              ),
              // const SizedBox(width: 16),

            ],
          ),
          const SizedBox(height: 16),
          quantityWidget(),
          const SizedBox(height: 6),
          reviewAndRatingRow(
            double.parse(productDetails.product?.star.toString() ?? "0"),
            int.parse(productDetails.productId.toString()),
            context,
          ),
          const SizedBox(height: 12),
          descriptionCard(productDetails),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Container priceAndCartSection(String price) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 25,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "mn",
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "€ $price",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 58,
                child: GetBuilder<AddToCartController>(
                  builder: (controller) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        if (_selectedColor != null && _selectedSize != null) {
                          if (Get.find<AuthController>().isTokenNotNull) {
                            final response = await controller.addToCart(
                              widget.productId,
                              colorToString(_selectedColor!),
                              _selectedSize!,
                              noOfCartItem.value,
                            );

                            if (response) {
                              customToast(context, "Item added to cart");
                            } else {
                              customToast(context, "Failed to cart",
                                  isError: true);
                            }
                          } else {
                            Get.to(() => const VerifyEmailScreen());
                          }
                        }
                      },
                      child: controller.inProgress
                          ? const CenterCircularProgressIndicator()
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart_checkout),
                                SizedBox(width: 10),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "mn",
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorFromString(String colorCode) {
    String code = colorCode.toLowerCase();
    if (code == 'red') {
      return Colors.red;
    }
    if (code == 'black') {
      return Colors.black;
    }
    if (code == 'green') {
      return Colors.green;
    }
    if (code == 'blue') {
      return Colors.blue;
    } else {
      return Colors.white;
    }
  }

  String colorToString(String colorCode) {
    String code = colorCode;
    if (code == 'MaterialColor(primary value: Color(0xff4caf50))') {
      return 'Green';
    }
    if (code == 'MaterialColor(primary value: Color(0xfff44336))') {
      return 'Red';
    } else {
      return 'White';
    }
  }

  Widget quantityWidget() {
    return ValueListenableBuilder(
      valueListenable: noOfCartItem,
      builder: (_, value, __) {
        return Container(
          height: 52,
          width: 145,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  if (noOfCartItem.value > 1) {
                    noOfCartItem.value--;
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 36,
                child: Center(
                  child: Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  if (noOfCartItem.value < 10) {
                    noOfCartItem.value++;
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget descriptionCard(ProductDetailsDataModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Product Description",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "mn",
            ),
          ),
          const SizedBox(height: 18),
          Text(
            productDetails.product?.shortDes ?? "",
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.grey.shade700,
              fontFamily: "mn",
            ),
          ),
        ],
      ),
    );
  }
}

// marge de défilement sur la fiche produit
