import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // الألوان الرسمية من صور Givelify
  static const Color givelifyPink = Color(0xFFF77D8A);  // الخلفية البامبي (صورة 1)
  static const Color givelifyBlue = Color(0xFF2196F3);  // الخلفية الزرقاء (صورة 2)
  static const Color givelifyPurple = Color(0xFF7B1FA2); // الخلفية الموف (صورة 8)
  static const Color givelifyOrange = Color(0xFFF4511E); // زرار Give البرتقالي

  static const Color textBlack = Colors.black;
  static const Color textGrey = Color(0xFF616161);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      // الخط الافتراضي (Cairo قريب جداً من خطهم المودرن)
      textTheme: GoogleFonts.cairoTextTheme(),

      // تنسيق الأزرار البرتقالية الكبيرة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: givelifyOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 55), // عريض وطويل
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 2,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}