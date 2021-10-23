import 'package:flash_youtube_downloader/screens/home/providers/home_providers.dart';
import 'package:flash_youtube_downloader/screens/mini_player/providers/miniplayer_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomWillScope extends ConsumerWidget {
  final Widget child;
  final bool isHome;
  final Function(bool)? callBack;
  final PageController? pageController;
  // final MiniPlayerController controller;
  const CustomWillScope({
    Key? key,
    required this.child,
    this.pageController,
    this.isHome = false,
    // required this.controller,
    // required this.isSearch,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader reader) {
    final controller = reader(MiniPlayerProviders.miniPlayerC);
    final homeStateProvider = reader(HomeProviders.homeProvider);
    return WillPopScope(
      onWillPop: () async {
        if (controller.isClosed || !controller.initialized) {
          if (homeStateProvider.isSearch && isHome) {
            homeStateProvider.clear();
            return false;
          } else {
            if (pageController != null && pageController!.page == 1) {
              reader(HomeProviders.pageStateProvider(pageController!).notifier)
                  .setPage = 0;
              pageController?.jumpToPage(0);
              return false;
            }
            return true;
          }
        } else {
          controller.closeMiniPlayer();
          return false;
        }
      },
      child: child,
    );
  }
}
