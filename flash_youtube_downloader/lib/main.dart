import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/providers/home_providers.dart';
import 'screens/mini_player/mini_player.dart';
import 'screens/mini_player/providers/miniplayer_providers.dart';
import 'utils/scroll_behaviour.dart';
import 'utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        // showPerformanceOverlay: true,
        builder: (context, child) => MaterialApp(
          navigatorKey: Utils.navigationKey,
          title: 'Flutter Demo',
          theme: Utils.themeData(context, Brightness.light),
          darkTheme: Utils.themeData(context, Brightness.dark),
          home: const HomeScreen(),
          builder: (context, child) {
            return Consumer(
              builder: (context, watch, child) {
                final currentVideoState =
                    watch(HomeProviders.currentVideoStateProvider);
                final _miniPlayerController =
                    watch(MiniPlayerProviders.miniPlayerC);
                return Stack(
                  children: [
                    ScrollConfiguration(
                      behavior: NoEffectScrollConfig(),
                      child: child!,
                    ),
                    if (currentVideoState != null)
                      GestureDetector(
                        onHorizontalDragUpdate: (e) {
                          // for dismissing mini player
                          if (_miniPlayerController.isClosed) {
                            print(e.globalPosition);
                          }
                        },
                        child:
                            MiniPlayerWidget(controller: _miniPlayerController),
                      )
                    else
                      const SizedBox(),
                  ],
                );
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
