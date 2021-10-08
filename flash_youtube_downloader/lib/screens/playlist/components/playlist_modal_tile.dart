import 'package:flutter/material.dart';

class PlayListModalTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback? onPressed;
  const PlayListModalTile(
      {Key? key,
      required this.leadingIcon,
      this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        onPressed?.call();
      },
      child: SizedBox(
        height: 70,
        width: double.infinity,
        // color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              Icon(leadingIcon, size: 30),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  title,
                  style: theme.textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
