import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const InfoIcon({Key? key, required this.icon, required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          textDirection: TextDirection.rtl,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.normal,
              ),
        ),
      ],
    );
  }
}
