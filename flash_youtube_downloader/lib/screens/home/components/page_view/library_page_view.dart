import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_youtube_downloader/screens/playlist/hive_playlist_page.dart';
import 'package:flash_youtube_downloader/services/offline/hive/init.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/hive_download_item.dart';
import 'package:flash_youtube_downloader/services/offline/hive/models/playlist.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../widgets/library_item_tile.dart';

class LibraryPageView extends StatefulWidget {
  const LibraryPageView({Key? key}) : super(key: key);

  @override
  _LibraryPageViewState createState() => _LibraryPageViewState();
}

class _LibraryPageViewState extends State<LibraryPageView>
    with AutomaticKeepAliveClientMixin<LibraryPageView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    super.build(context);
    return SizedBox(
      child: Column(
        children: [
          const LibraryItemTile(
            leadingIcon: Icons.history,
            title: "History",
          ),
          LibraryItemTile(
            leadingIcon: Icons.vertical_align_bottom_outlined,
            menuType: MenuType.download,
            title: "Downloads",
            subTitle: ValueListenableBuilder<Box<HiveDownloadItem>>(
                valueListenable:
                    Hive.box<HiveDownloadItem>(HiveInit.hiveDownloadItems)
                        .listenable(),
                builder: (context, box, child) {
                  final downloads = box.values
                      .where((element) =>
                          element.downloadState == DownloadState.downloading ||
                          element.downloadState == DownloadState.paused)
                      .toList();
                  if (downloads.isEmpty) {
                    return const SizedBox();
                  }
                  return Text(
                    "${downloads.length} downloading",
                    style: theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.grey),
                  );
                }),
          ),
          const LibraryItemTile(
            leadingIcon: Icons.watch_later_outlined,
            menuType: MenuType.watchlater,
            title: "Watch Later",
          ),
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              top: 15.0,
              bottom: 15.0,
            ),
            child: Row(
              children: [
                Text(
                  "Playlist",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 3 +
                            Theme.of(context).textTheme.bodyText1!.fontSize!,
                      ),
                ),
              ],
            ),
          ),
          const LibraryItemTile(
            leadingIcon: Icons.add,
            color: Colors.lightBlueAccent,
            menuType: MenuType.playlist,
            title: "New Playlist",
          ),
          ValueListenableBuilder<Box<HivePlaylist>>(
            valueListenable:
                Hive.box<HivePlaylist>(HiveInit.hivePlaylistBoxName)
                    .listenable(),
            builder: (context, box, child) {
              final eligibleToDisplaylist = box.values
                  .where((element) => element.videos.isNotEmpty)
                  .toList();
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: eligibleToDisplaylist.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          Utils.navigationKey.currentState!.push(
                            MaterialPageRoute(
                              builder: (contex) =>
                                  HivePlaylistPage(playlist: e),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                height: double.infinity,
                                width: 80,
                                child: Center(
                                  child: Container(
                                    width: 50,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Utils.placeHolderColor,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          e.videos.first.avatarThumbnailUrl,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      e.playlistName,
                                      style:
                                          theme.textTheme.bodyText1!.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: theme.textTheme.bodyText1!.color,
                                      ),
                                    ),
                                    Text(
                                      e.videos.length.toString(),
                                      style: theme.textTheme.bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList());
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
