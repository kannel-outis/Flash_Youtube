part of channel_info;

// ignore: unused_element
class _Videos extends HookWidget {
  final ChannelInfo channel;

  const _Videos({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPagnationListview(growablePage: channel);
  }
}
