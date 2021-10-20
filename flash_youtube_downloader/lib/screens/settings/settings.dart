import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flash_youtube_downloader/screens/settings/providers/settings_provider.dart';
import 'package:flash_youtube_downloader/utils/countries.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/country_drop_down.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final ccStateNotifier =
        watch(SettingsProvider.contentCountryState.notifier);
    final ccState = watch(SettingsProvider.contentCountryState);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Country Content",
                  style: theme.textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  child: FutureBuilder<List<ContentCountry>>(
                    future:
                        Future.delayed(const Duration(milliseconds: 300), () {
                      return Country.countries
                          .map((e) => ContentCountry.fromJson(e))
                          .toList();
                    }),
                    initialData: const [],
                    builder: (context, snapshot) {
                      return CountryDropDown(
                        value: ccState,
                        listOfCodes: snapshot.data,
                        onChanged: (value) {
                          ccStateNotifier.setState(value!);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
