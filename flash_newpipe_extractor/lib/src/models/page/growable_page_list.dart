import 'page.dart' as page;

abstract class GrowablePage<T, K> {
  final page.Page? childPage;
  final K? child;
  const GrowablePage(this.childPage, this.child);

  void addToGrowableList(T item);
}
