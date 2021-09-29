import 'package:flash_youtube_downloader/providers/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchController =
    ChangeNotifierProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

class SearchBar extends ConsumerWidget {
  final HomeProvider? provider;

  const SearchBar({Key? key, this.provider}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(searchController);
    final theme = Theme.of(context);
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
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
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
                    provider?.textFieldFocus = false;
                    provider?.searchQuery = value;
                    provider?.searching = true;
                  },

                  onTap: () {
                    provider?.textFieldFocus = true;
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
