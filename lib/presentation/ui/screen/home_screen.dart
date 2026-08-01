import 'package:flutter/cupertino.dart';
import 'package:medical_app/data/models/product_model.dart';
import 'package:medical_app/presentation/state_holders/auth_controller.dart';
import 'package:medical_app/presentation/state_holders/bottom_nav_controller.dart';
import 'package:medical_app/presentation/state_holders/brand_list_controller.dart';
import 'package:medical_app/presentation/state_holders/category_list_controller.dart';
import 'package:medical_app/presentation/state_holders/home_banner_controller.dart';
import 'package:medical_app/presentation/state_holders/new_product_controller.dart';
import 'package:medical_app/presentation/state_holders/popular_product_controller.dart';
import 'package:medical_app/presentation/state_holders/read_profile_data_controller.dart';
import 'package:medical_app/presentation/state_holders/special_product_controller.dart';
import 'package:medical_app/presentation/ui/screen/account_screen.dart';
import 'package:medical_app/presentation/ui/screen/auth/verify_email_screen.dart';
import 'package:medical_app/presentation/ui/screen/cart_screen.dart';
import 'package:medical_app/presentation/ui/screen/category_screen.dart';
import 'package:medical_app/presentation/ui/screen/notification_screen.dart';
import 'package:medical_app/presentation/ui/screen/product_list_screen.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';
import 'package:medical_app/presentation/ui/widgets/brand_item_widget.dart';
import 'package:medical_app/presentation/ui/widgets/category_item_widget.dart';
import 'package:medical_app/presentation/ui/widgets/circular_progress_indicator.dart';
import 'package:medical_app/presentation/ui/widgets/home_widgets/banner_carousel.dart';
import 'package:medical_app/presentation/ui/widgets/home_widgets/circle_icon_button.dart';
import 'package:medical_app/presentation/ui/widgets/home_widgets/home_search_bar.dart';
import 'package:medical_app/presentation/ui/widgets/home_widgets/section_title.dart';
import 'package:medical_app/presentation/ui/widgets/product_card.dart';
import 'package:medical_app/presentation/ui/widgets/shimmer_effect/carousel_shimmer.dart';
import 'package:medical_app/presentation/ui/widgets/shimmer_effect/shimmer_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/banner_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<BannerItem> bannerList = [
    BannerItem(image: "assets/images/banner1.png"),
    BannerItem(image: "assets/images/banner2.png"),
    BannerItem(image: "assets/images/banner3.png"),
    BannerItem(image: "assets/images/banner_image_1.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

             const HomeSearchBar(),

              SizedBox(
                height: Get.height * 0.19,
                child: GetBuilder<HomeBannerController>(builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: SizedBox(
                        height: Get.height * 0.19,
                        width: Get.width,
                        child: ShimmerBannerCarousel(
                          height: Get.height * 0.16,
                        )),
                    child: BannerCarouselWidget(
                      height: Get.height * 0.16,
                      // bannerList: controller.bannerListModal.data ?? [],
                      bannerList: bannerList ?? [],
                    ),
                  );
                }),
              ),
              SectionTitle(
                isAll: false,
                title: 'All Categories',
                onTap: () {
                  Get.to(()=> const CategoryScreen());
                },
              ),
              categoryList,
              // SectionTitle(
              //   title: 'Brands',
              //   onTap: () {
              //     Get.to(() => const BrandsScreen());
              //   },
              // ),
            //  brandList,
            //   SectionTitle(
            //     title: 'Popular',
            //     onTap: () {
            //       Get.to(
            //         ProductListScreen(
            //           category: 'Popular',
            //           productListModel:
            //               Get.find<PopularProductController>().productListModel,
            //         ),
            //       );
            //     },
            //   ),
            //   popularProduct,
              SectionTitle(
                isAll: false,
                title: 'Popular Products',
                onTap: () {
                  Get.to(
                    ProductListScreen(
                      category: 'Popular ',
                      productListModel:
                          Get.find<NewProductController>().productListModel,
                    ),
                  );
                },
              ),
              _popularProducts(),
              SectionTitle(
                isAll: false,
                title: 'Special Products',
                onTap: () {
                  Get.to(
                    ProductListScreen(
                      category: 'Special ',
                      productListModel:
                          Get.find<NewProductController>().productListModel,
                    ),
                  );
                },
              ),
              _specialProducts(),
              // SectionTitle(
              //   title: 'Special ',
              //   onTap: () {
              //     Get.to(
              //       ProductListScreen(
              //         category: 'New',
              //         productListModel:
              //             Get.find<NewProductController>().productListModel,
              //       ),
              //     );
              //   },
              // ),
              // specialProduct,
              SizedBox(height: 8,),
              SectionTitle(
                isAll: true,
                title: 'Top Products',
                onTap: () {
                  Get.to(
                    ProductListScreen(
                      category: 'Special ',
                      productListModel:
                      Get.find<NewProductController>().productListModel,
                    ),
                  );
                },
              ),
              SizedBox(height: 8,),

              GetBuilder<NewProductController>(
                builder: (controller) {
                  return SizedBox(
                  //  height: Get.height,
                    child: Visibility(
                      visible: controller.inProgress == false,
                      replacement: SizedBox(
                        height: Get.height * 0.24,
                        width: double.infinity,
                        child: ShimmerGridView(
                            height: Get.height * 0.21, width: Get.width * 0.3),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.56,
                            mainAxisSpacing: 04,
                            crossAxisSpacing: 8
                          ),
                        itemCount: controller.productListModel.productList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            productModel: controller.productListModel.productList![index]
                          );
                        },),
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder<SpecialProductController> _specialProducts() {
    return GetBuilder<SpecialProductController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == false,
                  replacement: SizedBox(
                    height: Get.height * 0.24,
                    width: double.infinity,
                    child: ShimmerGridView(
                        height: Get.height * 0.21, width: Get.width * 0.3),
                  ),
                  child: productList(
                      controller.productListModel.productList ?? []),
                );
              },
            );
  }

  GetBuilder<NewProductController> _popularProducts() {
    return GetBuilder<NewProductController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == false,
                  replacement: SizedBox(
                    height: Get.height * 0.25,
                    width: double.infinity,
                    child: ShimmerGridView(
                        height: Get.height * 0.21, width: Get.width * 0.3),
                  ),
                  child: productList(
                      controller.productListModel.productList ?? []),
                );
              },
            );
  }

  GetBuilder<PopularProductController> get popularProduct {
    return GetBuilder<PopularProductController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == true,
                  replacement: SizedBox(
                    height: Get.height * 0.24,
                    width: double.infinity,
                    child: ShimmerGridView(
                        height: Get.height * 0.21, width: Get.width * 0.3),
                  ),
                  child: productList(
                      controller.productListModel.productList ?? []),
                );
              },
            );
  }

  GetBuilder<SpecialProductController> get specialProduct {
    return GetBuilder<SpecialProductController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      controller.productListModel.productList ?? []),
                );
              },
            );
  }

  SizedBox get categoryList {
    return SizedBox(
       height: 140,
      child: GetBuilder<CategoryListController>(builder: (controller) {
        return Visibility(
          visible: controller.inProgress == false,
          replacement: const ShimmerGridView(
            height: 50,
            width: 85,

          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categoryListModel.categoryList?.length ?? 0,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: controller.categoryListModel.categoryList![index],
              );
            },
            separatorBuilder: (_, __) {
              return SizedBox(
                width: Get.width * 0.007,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox get brandList {
    return SizedBox(
      height: Get.height * 0.125,
      child: GetBuilder<BrandListController>(builder: (controller) {
        return Visibility(
          visible: controller.inProgress == false,
          replacement: const ShimmerGridView(
            height: 50,
            width: 85,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.brandListModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return BrandItem(
                brand: controller.brandListModel.data![index],
              );
            },
            separatorBuilder: (_, __) {
              return SizedBox(
                width: Get.width * 0.007,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox productList(List<ProductModel> productList ) {

    return SizedBox(
      height: 230,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductCard(
            productModel: productList[index],
          );
        },
        separatorBuilder: (_, __) {
          return SizedBox(
            width: Get.width * 0.015,
          );
        },
      ),
    );
  }



  TextFormField get searchTextFormField {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle:
            TextStyle(fontFamily: 'Poppins', color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  AppBar get appBar => AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    automaticallyImplyLeading: false,

    titleSpacing: 20,

    title: const Row(
      children: [
        // const Text(
        //   '🩺',
        //   style: TextStyle(
        //     fontSize: 30,
        //     fontWeight: FontWeight.bold
        //   ),
        // ),
        //
        // SizedBox(width: 12),

        Text(
          "MedBlocks",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
            color: Color(0xff1E293B),
            fontFamily: 'mn',
          ),
        ),
      ],
    ),

    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          splashRadius: 24,
          onPressed: () {
            Get.to(() => const CartScreen());
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xff1E293B),
            size: 28,
          ),
        ),
      ),
    ],
  );}
