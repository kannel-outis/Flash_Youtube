import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomNestedView extends StatelessWidget {
  final Widget child;
  final int? videoCount;
  final VoidCallback? playIconOnpressed;
  final VoidCallback? saveButtonOnpressed;
  final VoidCallback? downloadButtonOnpressed;
  final VoidCallback? shareButtonOnpressed;
  const CustomNestedView({
    Key? key,
    this.downloadButtonOnpressed,
    this.playIconOnpressed,
    this.saveButtonOnpressed,
    this.shareButtonOnpressed,
    required this.child,
    this.videoCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return NestedScrollView(
      headerSliverBuilder: (context, hasSlivers) {
        return [
          SliverAppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: isDarkMode
                ? Utils.placeHolderColor
                : Utils.placeHolderColor.withOpacity(.1),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 70,
                    ),
                    SizedBox(
                      // width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: playIconOnpressed,
                            icon: Icon(
                              Icons.play_circle_rounded,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: saveButtonOnpressed,
                            icon: Icon(
                              Icons.library_add_check,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: downloadButtonOnpressed,
                            icon: Icon(
                              Icons.vertical_align_bottom_outlined,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: shareButtonOnpressed,
                            icon: Icon(
                              Icons.reply_sharp,
                              textDirection: TextDirection.rtl,
                              color: isDarkMode ? Colors.white : Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            titleSpacing: 70,
            title: Text(
              // "${.toString()} videos",
              "$videoCount videos",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          )
        ];
      },
      body: child,
    );
  }
}
