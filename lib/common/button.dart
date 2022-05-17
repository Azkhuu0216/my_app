// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Button extends StatefulWidget {
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
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.icon == null) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: widget.color, // background
            onPrimary: widget.color1, // foreground
          ),
          onPressed: () {
            widget.onPress();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: widget.color, // background
              onPrimary: widget.color1, // foreground
            ),
            onPressed: widget.onPress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon),
                const SizedBox(width: 20),
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      );
    }
  }
}
