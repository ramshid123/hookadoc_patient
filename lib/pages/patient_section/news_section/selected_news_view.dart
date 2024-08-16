import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app_v2/models/news_model.dart';
import 'package:doctor_app_v2/pages/patient_section/news_section/controller.dart';
import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SelectedNewsPage extends StatelessWidget {
  SelectedNewsPage({super.key, required this.controller});

  final Article article = Get.arguments;
  final NewsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      extendBody: true,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage ??
                'https://coolbackgrounds.io/images/backgrounds/white/white-unsplash-9d0375d2.jpg',
            height: (Get.height / 4) * 2.2,
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
              height: (Get.height / 4) * 2.2,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  ColorConstants.whiteColor.withOpacity(0.5),
                  ColorConstants.whiteColor,
                  ColorConstants.whiteColor,
                  ColorConstants.whiteColor,
                  ColorConstants.whiteColor,
                  ColorConstants.whiteColor,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight(20.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorConstants.whiteColor,
                            width: 5.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Icon(
                              Icons.navigate_before,
                              color: ColorConstants.darkGrey,
                              size: 40.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async => await controller.shareNews(
                          url: article.url, title: article.title),
                      child: Container(
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorConstants.whiteColor,
                            width: 5.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Icon(
                              Icons.share,
                              color: ColorConstants.darkGrey,
                              size: 30.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                kText(
                  text: article.title.split('-').first,
                  fontSize: 22,
                  maxLines: 10,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.darkGrey,
                ),
                kHeight(15.h),
                Container(
                  height: 2,
                  width: Get.width,
                  color: ColorConstants.darkGrey,
                ),
                kHeight(15.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    kText(
                      text: article.source.name,
                      color: ColorConstants.mediumGreyH,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    kText(
                      text: DateFormat('MMMM d, h:mm a')
                          .format(article.publishedAt),
                      // text: '   November 25, 5:02 PM',
                      color: ColorConstants.mediumGreyH,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                kHeight(10.h),
                kHeight(20.h),
                kText(
                  text: article.description ?? '_',
                  maxLines: 5,
                  color: ColorConstants.darkGrey,
                  fontSize: 17,
                ),
                kHeight(20.h),
                GestureDetector(
                  onTap: () async =>
                      await controller.launchNews(url: article.url),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.darkGrey,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kText(
                          text: 'Read More',
                          maxLines: 2,
                          color: ColorConstants.whiteColor,
                          fontSize: 17,
                        ),
                        kWidth(20.w),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorConstants.whiteColor,
                          size: 20.r,
                        ),
                      ],
                    ),
                  ),
                ),
                kHeight(20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
