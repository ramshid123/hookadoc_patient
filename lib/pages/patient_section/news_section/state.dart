import 'package:doctor_app_v2/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsState {
  final pageController = PageController();

  RxList<Article?> newsList = <Article?>[].obs;
  var pageSize = 10.obs;
  final newsScrollController = ScrollController();
  var totalResultsNo = 0.obs;
  var topNewsList = <Article?>[].obs;
}
