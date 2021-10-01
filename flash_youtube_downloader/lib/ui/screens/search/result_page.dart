import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/providers/home/home_provider.dart';
import 'package:flash_youtube_downloader/ui/widgets/custom_pagenation_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchResultsProvider = FutureProvider.autoDispose<Search>((ref) {
  final query = ref.watch(homeProvider).searchQuery;
  return Extract().getSearchResults(query!);
});

class ResultPage extends ConsumerWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureResult = watch(searchResultsProvider);
    return futureResult.when(
      data: (data) {
        return CustomPagnationListview(growablePage: data);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (o, s) => CustomErrorWidget<Search>(
        autoDisposeFutureProvider: searchResultsProvider,
      ),
    );
  }
}
