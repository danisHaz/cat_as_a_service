import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle getUiStyle(ThemeData theme){
  final baseStyle = theme.brightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
  return baseStyle.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: theme.bottomAppBarColor,
    systemNavigationBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
  );
}