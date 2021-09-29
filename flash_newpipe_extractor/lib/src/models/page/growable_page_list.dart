import 'page_manager.dart';

abstract class GrowablePage<T, K extends GrowablePage<T, K>> {
  final PageManager<T, K> manager;
  final String type;
  const GrowablePage(this.manager, this.type, this.growableListItems);
  final List<T> growableListItems;
  void addToGrowableList(T item);
}
