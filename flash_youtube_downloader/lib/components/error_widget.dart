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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$message"),
          const SizedBox(height: 10),
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(Icons.refresh_outlined),
          // ),
          SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.refresh(future ?? autoDisposeFutureProvider!);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Center(
                child: Text(
                  "Retry",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.color
                                ?.withOpacity(.7) ??
                            Colors.grey,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
