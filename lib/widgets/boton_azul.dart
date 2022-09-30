// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  final String text;
  final Function() onPress;
  const BtnAzul({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        elevation: 2,
        shape: const StadiumBorder(),
      ),
      onPressed: onPress,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}
