import 'page/page.dart';

abstract class GrowablePageList<T, K> {
  final Page? childPage;
  final K? child;
  const GrowablePageList(this.childPage, this.child);
  void addToGrowableList(T item);
}
