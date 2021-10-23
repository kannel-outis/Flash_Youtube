// as sb;
import 'package:flash_youtube_downloader/screens/home/components/search_bar.dart';
import 'package:flash_youtube_downloader/screens/home/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'result_page.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const containerHeight = 60.0;
    final homeStates = watch(HomeProviders.homeProvider);
    final searchController = watch(SearchBar.searchController);
    final searchTextfieldFocusNode = watch(SearchBar.focusNode);
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: !homeStates.searching || searchTextfieldFocusNode.hasFocus
          ? SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: homeStates.suggestions.map(
                  (e) {
                    return Container(
                      // color: Colors.black,
                      height: containerHeight,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 20),
                          const SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeStates.searchQuery = e;
                                searchTextfieldFocusNode.unfocus();
                                homeStates.searching = true;
                                searchController.value =
                                    searchController.value.copyWith(
                                  text: e,
                                  selection: TextSelection.fromPosition(
                                    TextPosition(offset: e.length),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.left,
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              searchController.value =
                                  searchController.value.copyWith(
                                text: e,
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: e.length),
                                ),
                              );
                            },
                            child: const SizedBox(
                              // same as the parent container size
                              height: containerHeight,
                              width: containerHeight,
                              child: Icon(Icons.north_east, size: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            )
          : const ResultPage(),
    );
  }
}
