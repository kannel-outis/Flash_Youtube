import 'page/page.dart';

abstract class GrowablePage<T, K> {
  final Page? childPage;
  final K? child;
  const GrowablePage(this.childPage, this.child);
  void addToGrowableList(T item);
}
