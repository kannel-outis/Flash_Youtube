import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'ui/screens/home/home_screen.dart';
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
        builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: Utils.themeData(context, Brightness.light),
          darkTheme: Utils.themeData(context, Brightness.dark),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
