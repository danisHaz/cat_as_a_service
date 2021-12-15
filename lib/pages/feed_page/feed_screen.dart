import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_basics_2/pages/base_error_page.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_data_state.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_error_page.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_main_page.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/colors.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FeedCubit, FeedDataState>(
        builder: (context, state) {
          if (state.err != null) {
            state.err.print();
            return const FeedErrorPage();
          } else if (state.isLoading) {
            return FeedMainPage(cats: state.data ?? <Cat>[], pageSize: 20);
          } else if (state.data != null) {
            return FeedMainPage(cats: state.data!, pageSize: 20);
          } else if (state.isUpdateRequired ?? false) {
            context
                .read<FeedCubit>()
                .getListOfCatsAsPage(numberOfCatsInPage: 20);
            return const Center(
                child: Text(
              "Updating...",
              style: TextStyle(color: mainBlue),
            ));
          }

          // every state is invalid
          return const BaseErrorPage();
        },
      ),
    );
  }
}
