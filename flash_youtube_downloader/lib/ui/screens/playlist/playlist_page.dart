import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/ui/widgets/custom_pagenation_widget.dart';
import 'package:flash_youtube_downloader/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final playlistFuture = FutureProvider.autoDispose.family<PlaylistInfo, String>(
  (ref, url) async {
    return Extract().getPlaylistInfo(url);
  },
);

class PlaylistPage extends ConsumerWidget {
  final Playlist playlist;
  const PlaylistPage({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);

    final playlistInfoFuture = watch(playlistFuture(playlist.playListUrl));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          playlist.playListName,
          style: theme.textTheme.headline5,
        ),
      ),
      body: playlistInfoFuture.when(
        data: (data) {
          return NestedScrollView(
            headerSliverBuilder: (context, hasSlivers) {
              return [
                SliverAppBar(
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size(double.infinity, 50),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 70,
                          ),
                          SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.play_circle_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.library_add_check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.vertical_align_bottom_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.reply_sharp,
                                  textDirection: TextDirection.rtl,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  titleSpacing: 70,
                  title: Text(
                    "${playlist.streamCount.toString()} videos",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                )
              ];
            },
            body: CustomPagnationListview(
              growablePage: data,
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (obj, stk) => CustomErrorWidget(
          autoDisposeFutureProvider: playlistFuture(playlist.playListUrl),
        ),
      ),
    );
  }
}
