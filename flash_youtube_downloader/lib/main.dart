import 'package:flash_youtube_downloader/screens/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/providers/home_providers.dart';
import 'screens/mini_player/mini_player.dart';
import 'screens/mini_player/providers/miniplayer_providers.dart';
import 'services/offline/hive/init.dart';
import 'services/offline/managers/shared_prefs_manager.dart';
import 'utils/scroll_behaviour.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefsManager.instance.getInstance();
  await HiveInit.init();
  await HiveInit.setAllCurrentDownloadingToPause();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        builder: (context, child) => Consumer(
          builder: (context, watch, cChild) {
            final themeMode = watch(SettingsProvider.themeSettings);
            return MaterialApp(
              darkTheme: Utils.themeData(context, Brightness.dark),
              theme: Utils.themeData(context, Brightness.light),
              themeMode: themeMode,
              home: child,
            );
          },
        ),
        home: Stack(
          children: [
            MaterialApp(
              builder: (context, child) {
                return Consumer(
                  builder: (context, watch, cChild) {
                    final themeMode = watch(SettingsProvider.themeSettings);
                    return MaterialApp(
                      navigatorKey: Utils.navigationKey,
                      darkTheme: Utils.themeData(context, Brightness.dark),
                      theme: Utils.themeData(context, Brightness.light),
                      themeMode: themeMode,
                      home: ScrollConfiguration(
                        behavior: NoEffectScrollConfig(),
                        child: const HomeScreen(),
                      ),
                    );
                  },
                );
              },
            ),
            Consumer(
              builder: (context, watch, child) {
                final currentVideoState =
                    watch(HomeProviders.currentVideoStateProvider);
                final _miniPlayerController =
                    watch(MiniPlayerProviders.miniPlayerC);
                if (currentVideoState != null) {
                  return ScrollConfiguration(
                    behavior: NoEffectScrollConfig(),
                    child: MiniPlayerWidget(controller: _miniPlayerController),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
