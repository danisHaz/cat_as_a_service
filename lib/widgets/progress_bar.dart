import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final Color? color;
  const ProgressBar({Key? key, this.color}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: CircularProgressIndicator(
        color: color ?? Colors.blue,
      )
    );
  }
}