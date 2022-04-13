import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final double height;
  final String placeholder;
  final IconData icon;

// ignore: use_key_in_widget_constructors
  const Input({
    required this.height,
    required this.placeholder,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    return Container(
      alignment: Alignment.center,
      height: height,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey.shade50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // icon
            Icon(
              icon,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#020202" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextFormField(
                initialValue: placeholder,
                maxLines: 1,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
                decoration: InputDecoration(
                    hintText: "ner",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
