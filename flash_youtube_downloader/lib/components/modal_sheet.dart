import 'package:flutter/material.dart';

class ModalSheet extends StatelessWidget {
  const ModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 200,
      child: Container(
        color: Colors.black,
      ),
    );
  }
}
