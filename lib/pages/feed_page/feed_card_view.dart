import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';

class FeedCardView extends StatelessWidget {
  final Cat cat;
  const FeedCardView({
    Key? key,
    required this.cat
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text("Tags: ${cat.tags.join(", ")}"),
          Image.network(
          BASE_URL + cat.url,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const ProgressBar();
          },
        ),
        ],
      ),
    );
  }
}