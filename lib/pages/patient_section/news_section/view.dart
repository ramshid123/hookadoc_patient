import 'package:doctor_app_v2/pages/patient_section/news_section/controller.dart';
import 'package:doctor_app_v2/pages/patient_section/news_section/widgets.dart';
import 'package:doctor_app_v2/shared/common/bottom_nav_bar.dart';
import 'package:doctor_app_v2/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class NewsPage extends GetView<NewsController> {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kBottomNavigationBar(index: 3),
      body: CustomScrollView(
        controller: controller.state.newsScrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 250.h,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              // title: kText(text: 'Header'),
              background: NewsWidgets.topNewsContainer(controller: controller),
            ),
          ),
          Obx(() {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: controller.state.newsList.length,
                (context, index) {
                  final article = controller.state.newsList[index];
                  return article == null
                      ? SizedBox(
                          height: 100.h,
                          width: 100.h,
                          child: const RiveAnimation.asset(
                              'assets/heart_rate_black (1).riv'),
                        )
                      : NewsWidgets.newsTile(
                          controller: controller,
                          article: article,
                          // dateTime: '2023-11-21T22:04:41Z',
                        );
                },
              ),
            );
          }),
        ],
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 250.h,
      //       width: Get.width,
      //       decoration: BoxDecoration(
      //         color: ColorConstants.darkGrey,
      //         image: DecorationImage(
      //           image: NetworkImage(
      //             'https://neurosciencenews.com/files/2023/11/hearing-loss-dementia-neurosince.jpg',
      //           ),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     kHeight(20.h),
      // Expanded(
      //   child: GetBuilder(
      //       init: controller,
      //       builder: (controller) {
      //         return ListView.builder(
      //           controller: controller.state.newsScrollController,
      //           shrinkWrap: true,
      //           itemCount: controller.state.newsList.length,
      //           itemBuilder: (context, index) {
      //             final article = controller.state.newsList[index];
      //             return article == null
      //                 ? SizedBox(
      //                     height: 100.h,
      //                     width: 100.h,
      //                     child: const RiveAnimation.asset(
      //                         'assets/heart_rate_black (1).riv'),
      //                   )
      //                 : NewsWidgets.newsTile(
      //                     controller: controller,
      //                     article: article,
      //                     // dateTime: '2023-11-21T22:04:41Z',
      //                   );
      //           },
      //         );
      //       }),
      // ),
      //   ],
      //   ),
    );
  }
}
