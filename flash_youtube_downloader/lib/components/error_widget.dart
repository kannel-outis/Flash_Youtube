import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomErrorWidget<T> extends StatelessWidget {
  final FutureProvider<T>? future;
  final AutoDisposeFutureProvider<T>? autoDisposeFutureProvider;
  final String? errorMessage;
  final Object obj;
  const CustomErrorWidget({
    Key? key,
    this.future,
    this.errorMessage,
    required this.obj,
    this.autoDisposeFutureProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = (obj as dynamic).message;
    return Center(
      child: Column(
        children: [
          Text("$message"),
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
