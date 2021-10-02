import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/screens/mini_player/components/mini_player_draggable.dart';
import 'package:flash_youtube_downloader/utils/extensions.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

import '../channel_info.dart';

class ChannelTile extends StatelessWidget {
  final Channel channel;
  final MiniPlayerController controller;
  const ChannelTile({
    Key? key,
    required this.channel,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Utils.navigationKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => ChannelInfoPage(
              controller: controller,
              uploaderUrl: channel.channelUrl,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        // color: Colors.black,
        height: Utils.blockHeight * 12,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              // width: Utils.blockWidth * 40,
              child: Center(
                child: Container(
                  height: Utils.blockWidth * 20,
                  width: Utils.blockWidth * 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        channel.thumbnailUrl,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            channel.channelName,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            "${channel.subscriberCount.toString().convertToViews(true, false)} subscribers  •   ${channel.streamCount.toString().convertToViews()} videos",
                            style: theme.textTheme.bodyText2!.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
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
