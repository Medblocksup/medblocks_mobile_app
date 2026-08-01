import 'package:medical_app/data/models/product_model.dart';
import 'package:medical_app/presentation/state_holders/wishlist_controller.dart';
import 'package:medical_app/presentation/ui/screen/product_details_screen.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final bool? isWishProduct;

  const ProductCard({
    super.key,
    required this.productModel,
    this.isWishProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Get.to(
              () => ProductDetailScreen(
            productId: productModel.id!.toInt(),
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xffEEF2F7),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            Stack(
              children: [
                Container(
                  height: 105,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  child: Image.network(
                    "https://medblocks.appsowk.org/${productModel.image}",
                    fit: BoxFit.cover,
                  ),
                ),

                /// Favourite
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      if (isWishProduct == true) {
                        await Get.find<WishlistController>()
                            .deleteFromWishList(productModel.id!.toInt());
                      } else {
                        await Get.find<WishlistController>()
                            .addToWishList(
                          productModel.id!.toInt(),
                          context,
                        );
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        isWishProduct == true
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xffECFDF5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "In Stock",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff059669),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Title
                    Text(
                      productModel.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E293B),
                        height: 1.35,
                        fontFamily: "mn",
                      ),
                    ),

                    // const Spacer(),

                    /// Rating
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.star_rounded,
                    //       color: Colors.amber,
                    //       size: 15,
                    //     ),
                    //     const SizedBox(width: 4),
                    //     Text(
                    //       productModel.star.toString(),
                    //       style: const TextStyle(
                    //         fontSize: 12,
                    //         color: Color(0xff64748B),
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 5),

                    /// Price + Add
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "€ ${productModel.price}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontFamily: "mn",
                            ),
                          ),
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            // Add to cart
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}