import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/home_provider.dart';
import 'package:flash_youtube_downloader/ui/screens/search/result_page.dart';
import 'package:flash_youtube_downloader/ui/widgets/custom_pagenation_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/search_bar.dart' as sb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const containerHeight = 60.0;
    final homeStates = watch(homeProvider);
    final searchController = watch(sb.searchController);
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: !homeStates.searching || homeStates.textFieldFocus
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
                                homeStates.textFieldFocus = false;
                                homeStates.searching = true;
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
                                                  fontWeight:
                                                      FontWeight.normal),
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
