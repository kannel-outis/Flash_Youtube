import 'package:flash_youtube_downloader/models/content_country.dart';
import 'package:flutter/material.dart';

class CountryDropDown extends StatelessWidget {
  final List<ContentCountry>? listOfCodes;

  final ContentCountry? value;
  final Function(ContentCountry?)? onChanged;
  const CountryDropDown({
    Key? key,
    this.listOfCodes,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SizedBox(
        child: DropdownButton<ContentCountry>(
          dropdownColor: theme.scaffoldBackgroundColor,
          value: value ?? listOfCodes![0],
          underline: const SizedBox(),
          elevation: 0,
          items: listOfCodes!
              .map(
                (e) => DropdownMenuItem<ContentCountry>(
                  value: e,
                  child: SizedBox(
                    width: 250,
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 18,
                          child: Text(
                            e.countryName,
                            style: theme.textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          child: Text(
                            e.countryCode,
                            style: theme.textTheme.bodyText1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
