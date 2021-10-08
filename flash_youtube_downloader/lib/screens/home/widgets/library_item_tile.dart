import 'package:flash_youtube_downloader/screens/watchLater/watch_later.dart';
import 'package:flash_youtube_downloader/utils/enums.dart';
import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class LibraryItemTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData leadingIcon;
  final IconData? trailingIcon;
  final MenuType? menuType;
  const LibraryItemTile({
    Key? key,
    required this.leadingIcon,
    this.subTitle,
    required this.title,
    this.trailingIcon,
    this.menuType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        if (menuType == null) {
          return;
        }

        switch (menuType) {
          case MenuType.watchlater:
            Utils.navigationKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => const WatchLater(),
              ),
            );
            break;
          default:
        }
      },
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: 80,
              child: Center(
                child: Icon(leadingIcon, size: 23),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: theme.textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: double.infinity,
              width: 80,
              child: Center(
                child: Icon(trailingIcon, size: 23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
