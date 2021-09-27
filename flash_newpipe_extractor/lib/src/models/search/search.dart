import 'package:flash_newpipe_extractor/src/models/info_item.dart';
import 'package:flash_newpipe_extractor/src/models/page/growable_page_list.dart';
import 'package:flash_newpipe_extractor/src/models/page/page.dart';
import 'package:flash_newpipe_extractor/src/models/page/page_manager.dart';

class Search extends PageManager<InfoItem, Search>
    implements GrowablePage<InfoItem, Search> {
  final String? searchSuggestion;
  final String searchString;
  final List<String> metaInfo;
  final bool isCorrectedSearch;

  Search({
    this.searchSuggestion,
    required this.searchString,
    required this.metaInfo,
    this.isCorrectedSearch = false,
  }) {
    super.child = this;
  }
  List<InfoItem> get searchResults => _searchResults;
  List<InfoItem> _searchResults = [];

  @override
  void addToGrowableList(InfoItem item) {
    _searchResults.add(item);
  }

  @override
  Search? get child => this;

  @override
  Page? get childPage => super.page;

  factory Search.fromMap(Map<String, dynamic> map) {
    return Search(
      searchString: map["searchString"],
      isCorrectedSearch: map["isCorrectedSearch"],
      metaInfo: List.from(map["metaInfo"]),
      searchSuggestion: map["searchSuggestion"],
    );
  }
}
