part of channel_info;

// ignore: unused_element
class _Videos extends HookWidget {
  final Channel channel;

  const _Videos({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Consumer(
      builder: (context, watch, child) {
        final channelVideoState = watch(channelVideoProvider(channel));
        final channelVideoNotifier =
            watch(channelVideoProvider(channel).notifier);
        return Scrollbar(
          controller: controller,
          isAlwaysShown: false,
          thickness: 0,
          hoverThickness: 0,
          notificationPredicate: (notification) {
            if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent &&
                !channelVideoState) {
              channelVideoNotifier.hasReachedEnd = true;
              channelVideoNotifier.fetchNextItems();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: channel.videoUploads.length,
            itemBuilder: (context, index) {
              final video = channel.videoUploads[index];
              return Column(
                children: [
                  v.VideoInfoTile(video: video),
                  if (index == (channel.videoUploads.length - 1) &&
                      channelVideoState)
                    const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (index == (channel.videoUploads.length - 1))
                    SizedBox(
                      height: 70,
                      child: channelVideoNotifier.hasReachedLastPage
                          ? const Center(
                              child: Text("You have reached the bottom"),
                            )
                          : const SizedBox(),
                    )
                  else
                    const SizedBox(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
