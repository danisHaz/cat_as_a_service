import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';

class CatPreview extends StatelessWidget {
  final Cat cat;
  final _heroTag = UniqueKey();
  void Function(Key tag)? onTap;
  CatPreview({Key? key, required this.cat, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$BASE_URL${cat.url}'),
                fit: BoxFit.cover,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (onTap != null) onTap!(_heroTag);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}