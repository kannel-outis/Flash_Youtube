library home;

import 'package:flash_youtube_downloader/components/custom_will_scope.dart';
import 'package:flash_youtube_downloader/components/grid_view_widget.dart';
import 'package:flash_youtube_downloader/screens/mini_player/components/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/screens/mini_player/providers/miniplayer_providers.dart';
import 'package:flash_youtube_downloader/screens/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/utils/utils.dart';
import 'components/search_bar.dart';
import 'providers/home_providers.dart';

part 'components/trending.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final _miniPlayerController = watch(MiniPlayerProviders.miniPlayerC);
    final homeStates = watch(HomeProviders.homeProvider);
    return Scaffold(
      body: CustomWillScope(
        isHome: true,
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
                              const Text("Trending"),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                homeStates.isSearch = true;
                              },
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            child: homeStates.isSearch
                ? const SearchPage()
                : _Trending(_miniPlayerController),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
