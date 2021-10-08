import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/playlist/providers/playlist_providers.dart';
import 'package:flash_youtube_downloader/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPlaylistDialog extends HookWidget {
  final YoutubeVideo? video;
  const AddPlaylistDialog({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = useTextEditingController();
    final playlistProvider = useProvider(PlaylistProviders.playlistProvider);
    return Builder(
      builder: (context) => Dialog(
        child: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Text(
                        "Create Playlist",
                        style: theme.textTheme.bodyText1!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                autocorrect: false,
                controller: controller,
                autofocus: true,
                style: theme.textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                cursorColor: theme.accentColor,
                decoration: const InputDecoration(
                  hintText: "Playlist Name",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 12, right: 12, bottom: 8),
                ),
                onFieldSubmitted: (value) {
                  final hiveYoutubeVideo =
                      video == null ? null : Helper.youtubeVideoHelper(video!);
                  playlistProvider.createPlaylist(hiveYoutubeVideo, value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
