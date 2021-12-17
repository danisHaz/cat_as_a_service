import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedErrorPage extends StatelessWidget {
  const FeedErrorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'network_error'.tr(),
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<FeedCubit>().refreshCats(numberOfCatsInPage: 20);
            },
            child: Text('refresh'.tr()),
          ),
        ],
      ),
    );
  }
}
