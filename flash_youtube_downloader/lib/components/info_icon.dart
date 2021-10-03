import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  const InfoIcon(
      {Key? key, required this.icon, required this.label, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            textDirection: TextDirection.rtl,
            size: 23,
          ),
          const SizedBox(height: 7),
          Text(
            capitalize(label),
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }

  String capitalize(String label) {
    final labelSplit = label.split("");
    final checkIfNumber = int.tryParse(labelSplit.first);
    if (checkIfNumber != null) return label;
    final bigFirst = labelSplit.first.toUpperCase();
    labelSplit.insert(1, bigFirst);
    return labelSplit.join().substring(1, labelSplit.length);
  }
}
