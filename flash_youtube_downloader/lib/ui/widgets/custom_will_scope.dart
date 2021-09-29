import 'package:flash_youtube_downloader/ui/widgets/mini_player/mini_player_draggable.dart';
import 'package:flutter/widgets.dart';

class CustomWillScope extends StatelessWidget {
  final Widget child;
  final bool isSearch;
  final Function(bool)? callBack;
  final MiniPlayerController controller;
  const CustomWillScope({
    Key? key,
    required this.child,
    required this.controller,
    required this.isSearch,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("object");
        if (isSearch) {
          callBack?.call(false);
          return false;
        } else {
          if (controller.isClosed) {
            return true;
          } else {
            controller.closeMiniPlayer();
            return false;
          }
          // return true;
        }
      },
      child: child,
    );
  }
}
