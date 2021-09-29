import 'package:flash_youtube_downloader/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomErrorWidget<T> extends StatelessWidget {
  final FutureProvider<T>? future;
  final AutoDisposeFutureProvider<T>? autoDisposeFutureProvider;
  const CustomErrorWidget(
      {Key? key, this.future, this.autoDisposeFutureProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Something happened"),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {
              context.refresh(future ?? autoDisposeFutureProvider!);
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
    );
  }
}
