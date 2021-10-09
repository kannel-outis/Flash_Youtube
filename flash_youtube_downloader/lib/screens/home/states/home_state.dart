import 'dart:ui';

import 'package:flash_newpipe_extractor/flash_newpipe_extractor.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: unnecessary_getters_setters
class HomeState extends ChangeNotifier {
  final Extract _extract;

  HomeState(
    this._extract,
  );
  bool _isSearch = false;
  bool _searching = false;
  // bool _textFieldFocus = false;
  String? _searchQuery;
  List<String> _suggestions = [];

  set isSearch(bool isSearch) {
    _isSearch = isSearch;
    if (isSearch == false) {
      _suggestions.clear();
    }
    notifyListeners();
  }

  set searching(bool searching) {
    _searching = searching;
    notifyListeners();
  }

  set searchQuery(String? query) {
    _searchQuery = query;
    notifyListeners();
  }

  // set textFieldFocus(bool focus) {
  //   _textFieldFocus = focus;
  //   notifyListeners();
  // }

  Future<void> getSuggestions(String query) async {
    _suggestions = await _extract.getSearchSuggestions(query);
    notifyListeners();
  }

  void clear() {
    _searchQuery = null;
    _suggestions = [];
    _searching = false;
    _isSearch = false;
    notifyListeners();
  }

  bool get isSearch => _isSearch;
  bool get searching => _searching;
  // bool get textFieldFocus => _textFieldFocus;
  String? get searchQuery => _searchQuery;
  List<String> get suggestions => _suggestions;
}
