import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

import '../playlist_page.dart';

class PlayListTile extends StatelessWidget {
  final Playlist playlist;
  const PlayListTile({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.navigationKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => PlaylistPage(playlist: playlist),
          ),
        );
      },
      child: Container(
        // color: Colors.black,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(left: 10),
        width: double.infinity,
        // height: 165,
        height: Utils.blockHeight * 12.22,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
                child: Stack(
                  children: [
                    Align(
                      child: CachedNetworkImage(
                        width: double.infinity,
                        // height: 20,
                        imageUrl: playlist.avatarThumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: Utils.blockWidth * 25,
                        color: Colors.black.withOpacity(.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              playlist.streamCount.toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const Icon(Icons.playlist_play),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        playlist.playListName,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    SizedBox(height: Utils.blockWidth),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        playlist.uploaderName,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.grey,
                            ),
                        textAlign: TextAlign.left,
                        // maxLines: 2,
                      ),
                    ),
                    SizedBox(height: Utils.blockWidth),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${playlist.streamCount.toString()} videos",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.grey,
                            ),
                        textAlign: TextAlign.left,
                        // maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
