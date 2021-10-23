import 'package:flash_youtube_downloader/screens/home/providers/home_providers.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNav extends ConsumerWidget {
  final PageController pageController;
  const BottomNav({Key? key, required this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final pageStateProvider =
        watch(HomeProviders.pageStateProvider(pageController).notifier);
    final pageIndex = watch(HomeProviders.pageStateProvider(pageController));
    return SizedBox(
      height: 50,
      width: Utils.blockWidth * 100,
      child: BottomNavigationBar(
        elevation: 50,
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: isDarkMode ? Colors.white : Colors.black,
        onTap: (index) {
          pageStateProvider.setPage = index;
          pageController.jumpToPage(index);
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 20),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_rounded, size: 20),
            label: "Library",
          ),
        ],
      ),
    );
  }
}
