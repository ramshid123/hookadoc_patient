import 'dart:async';
import 'dart:developer';

import 'package:doctor_app_v2/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_index.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  NewsController();
  final state = NewsState();

  @override
  void onReady() async {
    // TODO: implement onReady
    await fetchNews(pageSize: state.pageSize.value);
    log('feteched news');
    await newsListExtendListener();
    log('news list extend listener');
    await autoAnimatePageView();
    log('auto animate page view');
    super.onReady();
  }

  Future autoAnimatePageView() async {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      if (state.pageController.page == state.topNewsList.length - 1) {
        state.pageController.animateToPage(0,
            duration: 500.milliseconds, curve: Curves.easeInOut);
      } else {
        await state.pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  String getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return years == 1 ? '1 yr ago' : '$years yrs ago';
    } else if (difference.inDays > 30) {
      int months = (difference.inDays / 30).floor();
      return months == 1 ? '1 mon ago' : '$months mon ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? '1h ago' : '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 min ago'
          : '${difference.inMinutes} min ago';
    } else {
      return 'now';
    }
  }

  Future newsListExtendListener() async {
    state.newsScrollController.addListener(() async {
      if (state.newsScrollController.position.atEdge) {
        final isBottom = state.newsScrollController.position.pixels != 0;
        if (isBottom) {
          await Future.delayed(2.seconds);
          if (state.pageSize.value < state.totalResultsNo.value) {
            state.pageSize.value += 10;
            await fetchNews(pageSize: state.pageSize.value);
          }
        }
      }
    });
  }

  Future shareNews({required String url, required String title}) async {
    await Share.share(url, subject: title);
  }

  Future launchNews({required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
    }
  }

  Future fetchNews({required int pageSize}) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=b716eeb6725f4c2887826b82cbf25850&pageSize=$pageSize'));
    final scrollPosition = state.newsScrollController.offset;

    final newsRespnse = NewsModel.fromRawJson(response.body);
    state.totalResultsNo.value = newsRespnse.totalResults;
    state.newsList.clear();
    state.topNewsList.clear();
    for (var article in newsRespnse.articles) {
        article.description ??= 'No Description Available';
        article.author ??= 'Unknown Author';
        state.newsList.value = [...state.newsList, article];
    }
    for (int i = 0; i < 4 && i < state.newsList.length; i++) {
      state.topNewsList.value = [...state.topNewsList, state.newsList[i]];
    }
    if (state.newsScrollController.hasClients) {
      state.newsScrollController.jumpTo(scrollPosition);
    }
    state.newsList.add(null);
    update();
  }
}
