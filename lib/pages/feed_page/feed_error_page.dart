import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedErrorPage extends StatelessWidget {
  const FeedErrorPage({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'feed_error_notify'.tr(), 
        style: TextStyle(color: Theme.of(context).errorColor),
      )
    );
  }
}