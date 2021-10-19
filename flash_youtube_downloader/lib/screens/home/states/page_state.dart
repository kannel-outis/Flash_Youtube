import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageState extends StateNotifier<int> {
  final PageController pageController;

  PageState(this.pageController) : super(0);

  // ignore: avoid_setters_without_getters
  set setPage(int page) {
    state = page;
  }
}
