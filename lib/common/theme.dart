import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double defaultPadding = 20;
double defaultBorderRadius = 15;

String baseAPIURL() {
  return "http://192.168.1.2:8080/api";
}

Map<String, String> header(
  bool isNeedToken, {
  String? token,
}) {
  if (isNeedToken == true) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  } else {
    return {
      'Accept': 'application/json',
    };
  }
}

Map<String, String> headerMultipart(
  bool isNeedToken, {
  String? token,
}) {
  if (isNeedToken == true) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
  } else {
    return {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
  }
}

String cuttedName(String name) {
  if (name.contains(" ")) {
    return name.substring(0, name.indexOf(" "));
  } else {
    return name;
  }
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool keyboardIsOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom != 0;
}

String formatWaktu(bool isTanggal, {DateTime? tanggal}) {
  final DateFormat formatterTanggal = DateFormat('dd MMMM yyyy', 'id');
  final DateFormat formatterJam = DateFormat('HH.mm');
  String formattedDate = "";

  if (isTanggal) {
    formattedDate = formatterTanggal.format(tanggal!);

    return formattedDate;
  } else {
    formattedDate = formatterJam.format(tanggal!);

    return formattedDate;
  }
}

Color primaryColor = const Color(0xFF66806A);
Color secondaryColor = const Color(0xFFB4C6A6);
Color tertiaryColor = const Color(0xffCCD5CD);
Color grey700 = const Color(0xFF111114);
Color grey600 = const Color(0xFF2b2b30);
Color grey500 = const Color(0xFF4b4b53);
Color grey400 = const Color(0xFF6d6d75);
Color black = const Color(0xFF000000);
Color white = const Color(0xFFFFFFFF);

BoxShadow primaryShadow = BoxShadow(
  blurRadius: 5,
  color: grey400.withOpacity(0.3),
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: white,
  fontWeight: regular,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: black,
  fontWeight: regular,
);

TextStyle eduPelitaTextStyle = GoogleFonts.comfortaa(
  color: black,
  fontWeight: regular,
);
