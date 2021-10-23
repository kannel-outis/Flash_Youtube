import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class DurationStack extends StatelessWidget {
  final YoutubeVideo video;
  const DurationStack({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.9),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            Utils.trimTime(video.duration.toString()),
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
