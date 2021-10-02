import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/home/providers/home_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: avoid_classes_with_only_static_members
class SearchProviders {
  static final searchResultsProvider =
      FutureProvider.autoDispose<Search>((ref) {
    final query = ref.watch(HomeProviders.homeProvider).searchQuery;
    return Extract().getSearchResults(query!);
  });
}
