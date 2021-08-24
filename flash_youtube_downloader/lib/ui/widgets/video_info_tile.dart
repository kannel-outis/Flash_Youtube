import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class VideoInfoTile extends StatelessWidget {
  const VideoInfoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: Utils.blockHeight * 27,
      width: double.infinity,
      constraints: const BoxConstraints(
        maxHeight: 400,
        minHeight: 250,
      ),
      child: Column(
        children: [
          Container(
            height: Utils.blockHeight * 20,
            color: Colors.black,
            child: Stack(
              children: [
                Positioned(
                  height: 20,
                  width: 50,
                  bottom: 20,
                  right: 20,
                  child: Container(
                    color: Colors.pink,
                    child: Center(
                      child: Text(
                        "11:20",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
