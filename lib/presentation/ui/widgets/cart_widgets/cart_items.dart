import 'package:flutter/cupertino.dart';
import 'package:medical_app/data/models/cart_item.dart';
import 'package:medical_app/presentation/state_holders/cart_list_controller.dart';
import 'package:medical_app/presentation/ui/screen/product_details_screen.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'package:medical_app/presentation/ui/utility/utils.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  late ValueNotifier<int> noOfCartItem =
      ValueNotifier(widget.cartItem.quantity);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailScreen(productId:widget.cartItem.productId!));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
          Container(
          width: 95,
          height: 95,
          decoration: BoxDecoration(
            color: const Color(0xffF6F8FB),
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            getImage(widget.cartItem.product!.image.toString()) ?? '',
            fit: BoxFit.contain,
          ),
        ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartItem.product?.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "mn",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff1E293B),
                              ),
                            ),
                            Text(
                              widget.cartItem.product!.shortDes ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: Colors.grey,
                                  fontFamily: 'mn',
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                textConfirm: 'Delete',
                                textCancel: 'Cancel',
                                title: 'Delete',
                                middleText: 'Are you want to delete from cart?',
                                confirmTextColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                titleStyle: const TextStyle(
                                    fontFamily: 'mn',
                                    color: AppColors.primaryColor),
                                middleTextStyle:
                                    const TextStyle(fontFamily: 'mn'),
                                buttonColor: AppColors.primaryColor,
                                onConfirm: () async {
                                  Get.back();
                                  final response =
                                      await Get.find<CartListController>()
                                          .deleteFromCart(widget
                                              .cartItem.product!.id!
                                              .toInt());
                                  if (response) {
                                    await Get.find<CartListController>()
                                        .getCartList();
                                  } else {
                                    customToast(
                                        context, "Unable to delete from cart",
                                        isError: true);
                                  }
                                },
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.delete,
                              color: AppColors.primaryColor,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "€ ${widget.cartItem.product?.price}",
                        style: const TextStyle(
                          fontFamily: "mn",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: noOfCartItem,
                        builder: (context, value, _) {
                          return ItemCount(
                            initialValue: value,
                            minValue: 1,
                            maxValue: 10,
                            step: 1,
                            color: AppColors.primaryColor.withOpacity(0.9),
                            buttonSizeHeight: 24,
                            buttonSizeWidth: 34,
                            textStyle: const TextStyle(
                              fontFamily: 'mn',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            onChanged: (v) {
                              noOfCartItem.value = v.toInt();
                              Get.find<CartListController>().updateQuantity(
                                  widget.cartItem.id!, noOfCartItem.value);
                            },
                            decimalPlaces: 0,
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
