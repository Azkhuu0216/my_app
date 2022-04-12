import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final Color color1;
  final double height;
  final double width;
  final VoidCallback onPress;
  final IconData? icon;

  // ignore: use_key_in_widget_constructors
  Button(this.height, this.width, this.title, this.color, this.color1,
      this.onPress, this.icon);

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color, // background
              onPrimary: color1, // foreground
            ),
            onPressed: onPress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      );
    } else {
      return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color, // background
              onPrimary: color1, // foreground
            ),
            onPressed: onPress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      );
    }
  }
}
