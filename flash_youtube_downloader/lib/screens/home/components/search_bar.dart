import 'package:flash_youtube_downloader/screens/home/states/home_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchBar extends ConsumerWidget {
  static final searchController =
      ChangeNotifierProvider.autoDispose<TextEditingController>((ref) {
    return TextEditingController();
  });

  static final focusNode = Provider.autoDispose<FocusNode>((ref) {
    return FocusNode();
  });
  final HomeState? provider;

  const SearchBar({Key? key, this.provider}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(searchController);
    final _focusNode = watch(focusNode);
    final theme = Theme.of(context);

    final isDarkTheme = theme.brightness == Brightness.dark;
    return SizedBox(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              provider?.clear();
            },
            iconSize: 20,
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: isDarkTheme
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  controller: controller,
                  // autofocus: true,
                  style: theme.textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                  cursorColor: theme.accentColor,
                  decoration: const InputDecoration(
                    hintText: "Search YouTube",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 12, right: 12, bottom: 8),
                  ),
                  onChanged: (value) {
                    provider?.getSuggestions(value);
                  },
                  onFieldSubmitted: (value) {
                    _focusNode.unfocus();
                    provider?.searchQuery = value;
                    provider?.searching = true;
                  },
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                iconSize: 20,
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller.clear();
                  controller.text = "";
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
