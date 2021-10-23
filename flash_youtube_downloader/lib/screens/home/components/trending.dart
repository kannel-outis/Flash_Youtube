part of home;

// ignore: must_be_immutable
class _Trending extends StatefulWidget {
  final MiniPlayerController _miniPlayerController;
  const _Trending(this._miniPlayerController);

  @override
  __TrendingState createState() => __TrendingState();
}

class __TrendingState extends State<_Trending>
    with AutomaticKeepAliveClientMixin<_Trending> {
  int gridCount = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    return Consumer(
      builder: (context, watch, child) {
        final futureTrendingVideos = watch(HomeProviders.trendingVideos);

        return futureTrendingVideos.when(
          data: (data) {
            if (data == null || data.isEmpty) {
              return const Center(
                child: Text("EMir dilony"),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                top: Utils.blockWidth * 2.0,
                left: Utils.blockWidth * 2.0,
                right: Utils.blockWidth * 2.0,
              ),
              child: GridViewWidget(
                gridCount: gridCount,
                maxWidth: maxWidth,
                data: data,
                heightWithMaxHeight: heightWithMaxHeight,
                miniPlayerController: widget._miniPlayerController,
              ),
            );
          },
          loading: () {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          },
          error: (obj, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomErrorWidget<List<YoutubeVideo>?>(
                  obj: obj,
                  future: HomeProviders.trendingVideos,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
