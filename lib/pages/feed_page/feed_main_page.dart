import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/blocs/feed_bloc.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_list_item.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:provider/src/provider.dart';

class FeedMainPage extends StatefulWidget {
  final List<Cat> cats;
  final int pageSize;

  const FeedMainPage({
    Key? key,
    required this.cats,
    required this.pageSize,
  }): super(key: key);

  @override
  FeedMainPageState createState() => FeedMainPageState();
}

class FeedMainPageState extends State<FeedMainPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (contex, index) {
        log(index.toString());
        return index >= widget.cats.length-1 ?
          const ProgressBar() :
          FeedListItem(cat: widget.cats[index],);
      },
      controller: _controller,
      itemCount: widget.cats.length,
    );
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    //log(cats.length.toString());
    if (_isBottom) {
      context
        .read<FeedCubit>()
        .getListOfCatsAsPage(numberOfCatsInPage: widget.pageSize);
    }
  }

  bool get _isBottom {
    if (!_controller.hasClients) return false;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}