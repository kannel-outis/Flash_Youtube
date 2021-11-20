import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaseStateNotifier<T> extends StateNotifier<T> {
  BaseStateNotifier(T initial) : super(initial);

  T get typeState => state;
}
