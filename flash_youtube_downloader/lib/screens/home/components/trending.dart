part of home;

// ignore: must_be_immutable
class _Trending extends ConsumerWidget {
  final MiniPlayerController _miniPlayerController;
  _Trending(this._miniPlayerController);
  int gridCount = 0;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureTrendingVideos = watch(HomeProviders.trendingVideos);

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
    return futureTrendingVideos.when(
      data: (data) {
        return Padding(
          padding: EdgeInsets.all(Utils.blockWidth * 2.0),
          child: GridViewWidget(
              gridCount: gridCount,
              maxWidth: maxWidth,
              data: data!,
              heightWithMaxHeight: heightWithMaxHeight,
              miniPlayerController: _miniPlayerController),
        );
      },
      loading: () {
        return const Center(
          child: CustomCircularProgressIndicator(),
        );
      },
      error: (obj, stackTrace) {
        return const Center(
          child: Text("Something Went Wrong....."),
        );
      },
    );
  }
}
