import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setSystemChrome(ThemeData theme){
  final baseStyle = theme.brightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
  SystemChrome.setSystemUIOverlayStyle(baseStyle.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: theme.bottomAppBarColor,
    systemNavigationBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
  ));
}