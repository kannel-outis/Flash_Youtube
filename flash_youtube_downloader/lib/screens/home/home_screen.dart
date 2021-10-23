library home;

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/components/circular_progress_indicator.dart';
import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/error_widget.dart';
import 'package:flash_youtube_downloader/components/grid_view_widget.dart';
import 'package:flash_youtube_downloader/screens/home/components/bottom_nav.dart';
import 'package:flash_youtube_downloader/screens/home/components/page_view/library_page_view.dart';
import 'package:flash_youtube_downloader/screens/mini_player/components/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/screens/mini_player/providers/miniplayer_providers.dart';
import 'package:flash_youtube_downloader/screens/search/search_page.dart';
import 'package:flash_youtube_downloader/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/utils/utils.dart';
import 'components/search_bar.dart';
import 'providers/home_providers.dart';

part 'components/trending.dart';

// ignore: must_be_immutable
class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _miniPlayerController = useProvider(MiniPlayerProviders.miniPlayerC);
    final homeStates = useProvider(HomeProviders.homeProvider);
    final pageController = usePageController();
    final pageStateProvider =
        useProvider(HomeProviders.pageStateProvider(pageController));
    return Scaffold(
      body: CustomWillScope(
        isHome: true,
        pageController: pageController,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            toolbarHeight: 70,
            elevation: 0.0,
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              child: homeStates.isSearch
                  ? SearchBar(
                      provider: homeStates,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  "assets/icons/youtube.png",
                                  scale: 18.0,
                                ),
                              ),
                              Text(
                                "Trending",
                                style: theme.textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: theme.iconTheme.color,
                              ),
                              onPressed: () {
                                homeStates.isSearch = true;
                              },
                            ),
                            if (pageStateProvider == 1)
                              IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: theme.iconTheme.color,
                                ),
                                onPressed: () {
                                  Utils.navigationKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (context) => SettingsPage(),
                                    ),
                                  );
                                },
                              )
                            else
                              const SizedBox(),
                          ],
                        )
                      ],
                    ),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            child: Stack(
              children: [
                Offstage(
                  offstage: !homeStates.isSearch,
                  child: const SearchPage(),
                ),
                Offstage(
                  offstage: homeStates.isSearch,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _Trending(_miniPlayerController),
                      const LibraryPageView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Offstage(
            offstage: homeStates.isSearch,
            child: BottomNav(pageController: pageController),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
