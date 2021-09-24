part of channel_info;

// ignore: unused_element
class _Videos extends ConsumerWidget {
  final Channel channel;
  const _Videos({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListView.builder(
      itemCount: channel.videoUploads.length,
      itemBuilder: (context, index) {
        final video = channel.videoUploads[index];
        return Column(
          children: [
            v.VideoInfoTile(video: video),
          ],
        );
      },
    );
  }
}
