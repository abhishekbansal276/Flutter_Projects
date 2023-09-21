import 'package:flutter/material.dart';

const MaterialColor navbarcolor = MaterialColor(_navbarcolorPrimaryValue, <int, Color>{
  50: Color(0xFFFEFEFF),
  100: Color(0xFFFDFDFF),
  200: Color(0xFFFCFCFF),
  300: Color(0xFFFAFAFF),
  400: Color(0xFFF9F9FF),
  500: Color(_navbarcolorPrimaryValue),
  600: Color(0xFFF7F7FF),
  700: Color(0xFFF6F6FF),
  800: Color(0xFFF5F5FF),
  900: Color(0xFFF3F3FF),
});
const int _navbarcolorPrimaryValue = 0xFFF8F8FF;

const MaterialColor navbarcolorAccent = MaterialColor(_navbarcolorAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_navbarcolorAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _navbarcolorAccentValue = 0xFFFFFFFF;