

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_app/data/models/banner_model.dart';
import 'package:medical_app/presentation/ui/utility/app_colors.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class BannerCarouselWidget extends StatefulWidget {
  final double height;
  final List<BannerItem> bannerList;

  const BannerCarouselWidget({
    required this.bannerList,
    super.key,
    required this.height,
  });

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
            height: widget.height ?? 180,
            viewportFraction: 1,
            autoPlay: true,
          ),
          items: widget.bannerList.map((i) {

            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      // width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          i.image! ?? '',
                          fit: BoxFit.fitHeight,
                          height: widget.height,

                        ),
                      ),
                    ),



                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * 0.5,
                              child: Text(
                                i.title ?? '',
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: Get.width * 0.4,
                              child: Text(
                                i?.shortDes ?? '',
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 4,
        ),
        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.bannerList.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,

                    width: i == index ? 24 : 8,
                    height: i == index ? 7 : 8,

                    margin: const EdgeInsets.symmetric(horizontal: 4),

                    decoration: BoxDecoration(
                      color: i == index
                          ? AppColors.primaryColor
                          : const Color(0xffD6D9DE),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )              ],
            );
          },
        )
      ],
    );
  }
}
