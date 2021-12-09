import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/base_error_page.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';

class FeedListItem extends StatelessWidget {
  final Cat cat;

  const FeedListItem({Key? key, required this.cat}): super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      log(BASE_URL + cat.url);
      final kitty = Image.network(BASE_URL + cat.url);
      return Card(
        child: Flexible(
          child: kitty
        )
      );
    } catch (e) {
      log("$e");
      return const BaseErrorPage();
    }

  }
}