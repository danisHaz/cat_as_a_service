import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/base_error_page.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';

class FeedListItem extends StatelessWidget {
  final Cat cat;

  const FeedListItem({Key? key, required this.cat}): super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Card(
        child: Image.network(
          BASE_URL + cat.url,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const ProgressBar();
          },
        ),
      );
    } catch (e) {
      log("$e");
      return const BaseErrorPage();
    }

  }
}