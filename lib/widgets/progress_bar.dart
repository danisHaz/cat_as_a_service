import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final Color? color;
  final DownloadProgress? loadingProgress;

  const ProgressBar({Key? key, this.color, this.loadingProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
            color: color ?? Theme.of(context).progressIndicatorTheme.color,
            value: loadingProgress?.progress));
  }
}
