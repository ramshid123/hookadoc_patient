import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app_v2/models/news_model.dart';
import 'package:doctor_app_v2/pages/patient_section/news_section/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/news_section/selected_news_view.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewsWidgets {
  static Widget topNewsContainer({required NewsController controller}) {
    return Obx(() {
      return PageView.builder(
        controller: controller.state.pageController,
        itemCount: controller.state.topNewsList.length,
        itemBuilder: (context, index) {
          return topNewsTile(index: index, controller: controller);
        },
      );
    });
  }

  static topNewsTile({required int index, required NewsController controller}) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: controller.state.topNewsList[index]!.urlToImage ??
              'https://coolbackgrounds.io/images/backgrounds/white/white-unsplash-9d0375d2.jpg',
          height: 250.h,
          width: Get.width,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: 250.h,
            width: Get.width,
          ).animate(onPlay: (animCont) {
            animCont.repeat();
          }).shimmer(
            color: ColorConstants.lightGrey,
            duration: 800.ms,
            delay: 800.ms,
          ),
          errorWidget: (context, url, error) => Image.network(
            'https://coolbackgrounds.io/images/backgrounds/white/white-unsplash-9d0375d2.jpg',
            height: 250.h,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          height: 250.h,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                ColorConstants.darkGrey.withOpacity(0.2),
                ColorConstants.darkGrey.withOpacity(0.4),
                ColorConstants.darkGrey.withOpacity(0.6),
                ColorConstants.darkGrey.withOpacity(0.8),
                ColorConstants.darkGrey.withOpacity(1),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              kText(
                text: '• ${controller.state.topNewsList[index]!.source.name}',
                color: ColorConstants.lightGrey,
                fontWeight: FontWeight.w500,
              ),
              kHeight(10.h),
              kText(
                text:
                    controller.state.topNewsList[index]!.title.split('-').first,
                maxLines: 3,
                color: ColorConstants.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
              kHeight(10.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async => await Get.to(
                        () => SelectedNewsPage(controller: controller),
                        arguments: controller.state.topNewsList[index]),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                            color: ColorConstants.whiteColor, width: 1.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kText(
                            text: 'Read More',
                            color: ColorConstants.whiteColor,
                            fontSize: 17,
                          ),
                          kWidth(10.w),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: ColorConstants.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  topNewsIndicator(
                      index: index,
                      totalLength: controller.state.topNewsList.length),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget topNewsIndicator(
      {required int index, required int totalLength}) {
    return Row(
      children: [
        for (int i = 0; i < totalLength; i++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            height: 10.h,
            width: index == i ? 25.h : 10.h,
            decoration: BoxDecoration(
              color: index == i
                  ? ColorConstants.whiteColor
                  : ColorConstants.mediumGreyL,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 2.w),
        //   height: 10.h,
        //   width: index == 1 ? 25.h : 10.h,
        //   decoration: BoxDecoration(
        //     color: index == 1
        //         ? ColorConstants.darkGrey
        //         : ColorConstants.mediumGreyH,
        //     borderRadius: BorderRadius.circular(50.r),
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 2.w),
        //   height: 10.h,
        //   width: index == 2 ? 25.h : 10.h,
        //   decoration: BoxDecoration(
        //     color: index == 2
        //         ? ColorConstants.darkGrey
        //         : ColorConstants.mediumGreyH,
        //     borderRadius: BorderRadius.circular(50.r),
        //   ),
        // ),
      ],
    );
  }

  static Widget newsTile({
    required NewsController controller,
    required Article article,
  }) {
    return GestureDetector(
      onTap: () async => await Get.to(
          () => SelectedNewsPage(controller: controller),
          arguments: article),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  kText(
                    text: '• ${article.source.name}',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  kHeight(7.h),
                  kText(
                    text: article.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                  kHeight(7.h),
                  kText(
                    text: controller.getTimeAgo(article.publishedAt),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.mediumGreyH,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            kWidth(10.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: article.urlToImage == null
                  ? Image.asset(
                      'assets/others/news_alt.png',
                      width: 100.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      width: 100.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 100.w,
                        height: 80.h,
                        color: ColorConstants.mediumGreyL,
                      ).animate(onPlay: (animCont) {
                        animCont.repeat();
                      }).shimmer(
                        color: ColorConstants.lightGrey,
                        duration: 800.ms,
                        delay: 800.ms,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/others/news_alt.png',
                        width: 100.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
