import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flutter/widgets.dart';

class CustomWillScope extends StatelessWidget {
  final Widget child;
  final MiniPlayerController controller;
  const CustomWillScope(
      {Key? key, required this.child, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isClosed) {
          return true;
        } else {
          controller.closeMiniPlayer();
          return false;
        }
      },
      child: child,
    );
  }
}
