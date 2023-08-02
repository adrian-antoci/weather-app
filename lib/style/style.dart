import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color pageBackground = Colors.black.withOpacity(0.8);

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 700;

Widget titleStrong(String text) => Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w900,
        letterSpacing: 0.5,
        fontSize: 42,
        height: 1.1,
      ),
    );
Widget paragraphStrong(String text) => Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        fontSize: 32,
        height: 1.1,
      ),
    );

String formatStatName(String name) {
  return name.replaceAll("-", "\n").capitalize();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
