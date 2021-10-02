import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/components/custom_pagenation_widget.dart';
import 'package:flash_youtube_downloader/components/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/search_providers.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureResult = watch(SearchProviders.searchResultsProvider);
    return futureResult.when(
      data: (data) {
        return CustomPagnationListview(growablePage: data);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (o, s) => CustomErrorWidget<Search>(
        autoDisposeFutureProvider: SearchProviders.searchResultsProvider,
      ),
    );
  }
}
