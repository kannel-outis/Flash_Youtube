import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flutter/material.dart';
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
    super.build(context);
    return SizedBox(
      child: Column(
        children: const [
          LibraryItemTile(
            leadingIcon: Icons.history,
            title: "History",
          ),
          LibraryItemTile(
            leadingIcon: Icons.vertical_align_bottom_outlined,
            title: "Downloads",
          ),
          LibraryItemTile(
            leadingIcon: Icons.watch_later_outlined,
            menuType: MenuType.watchlater,
            title: "Watch Later",
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
