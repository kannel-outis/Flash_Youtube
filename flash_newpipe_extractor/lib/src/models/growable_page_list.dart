import 'package:flutter/widgets.dart';

import 'page/page.dart' as page;

abstract class GrowablePage<T, K> {
  final page.Page? childPage;
  final K? child;
  const GrowablePage(this.childPage, this.child);

  @protected
  void addToGrowableList(T item);
}
