part of channel_info;

// ignore: must_be_immutable
class _Home extends StatelessWidget {
  final ChannelInfo data;
  final PaletteGenerator colorGen;
  final MiniPlayerController controller;
  _Home(
      {Key? key,
      required this.data,
      required this.colorGen,
      required this.controller})
      : super(key: key);
  int gridCount = 0;

  @override
  Widget build(BuildContext context) {
    final maxWidth = () {
      double screenWidth = 0.0;
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        screenWidth =
            MediaQuery.of(context).size.width - (20 + Utils.blockWidth * 4);
        if (screenWidth < 550) {
          gridCount = 1;
          return screenWidth;
        } else if (screenWidth > 550 && screenWidth < 960) {
          gridCount = 2;

          return screenWidth / 2;
        } else {
          gridCount = 3;
          return screenWidth / 3;
        }
      }
      screenWidth = MediaQuery.of(context).size.height - 20;
      if (screenWidth < 550) {
        gridCount = 2;
        return screenWidth;
      } else if (screenWidth > 550 && screenWidth < 960) {
        gridCount = 3;
        return screenWidth / 2;
      } else {
        gridCount = 4;
        return screenWidth / 3;
      }
    }();

    final heightWithMaxHeight = () {
      if (MediaQuery.of(context).size.width < 550) {
        return 250;
      } else if (MediaQuery.of(context).size.width > 700) {
        return 400;
      }
      return Utils.blockHeight * 18;
    }();
    final theme = Theme.of(context);
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView(
        children: [
          SizedBox(
            height: Utils.blockHeight * 21,
            child: Stack(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Container(
                        height: Utils.blockHeight * 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(data.bannerUrl ==
                                    null
                                ? "https://s.ytimg.com/yts/img/channels/c4/default_banner-vflYp0HrA.jpg"
                                : data.bannerUrl!),
                          ),
                        ),
                      ),
                      Container(
                        height: Utils.blockHeight * 7,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Row(
                          // mainAxisAlignment:
                          //     MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              // circle size plus left padding
                              width: (Utils.blockWidth * 25) + 30,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,
                                    style: theme.textTheme.headline5,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${data.subscriberCount.toString().convertToViews(true, false)} subscribers",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: Colors.white.withOpacity(.7),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  top: ((Utils.blockHeight * 12) / 2).abs(),
                  child: Container(
                    height: Utils.blockWidth * 25,
                    width: Utils.blockWidth * 25,
                    decoration: BoxDecoration(
                      color: colorGen.dominantColor!.color.withOpacity(.8),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 5,
                        color: colorGen.dominantColor!.color,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(data.hdAvatarUrl),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          GridViewWidget(
            physics: const NeverScrollableScrollPhysics(),
            showUploaderPic: false,
            gridCount: gridCount,
            itemsCount: 20,
            data: data.growableListItems,
            maxWidth: maxWidth,
            heightWithMaxHeight: heightWithMaxHeight,
            miniPlayerController: controller,
          ),
        ],
      ),
    );
  }
}
