import 'page_manager.dart';

abstract class GrowablePage<T> {
  final PageManager manager;
  final String type;
  const GrowablePage(this.manager, this.type);

  void addToGrowableList(T item);
}
