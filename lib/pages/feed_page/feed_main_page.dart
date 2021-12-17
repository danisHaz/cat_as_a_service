import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_bloc.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_list_item.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedMainPage extends StatefulWidget {
  final List<Cat> cats;
  final int pageSize;

  const FeedMainPage({
    Key? key,
    required this.cats,
    required this.pageSize,
  }) : super(key: key);

  @override
  FeedMainPageState createState() => FeedMainPageState();
}

class FeedMainPageState extends State<FeedMainPage> {
  final ScrollController _controller = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onRefresh() async {
    await context.read<FeedCubit>().refreshCats(numberOfCatsInPage: 20);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        header: ClassicHeader(
          failedText: "feed_main_page.failed_text".tr(),
          releaseText: "feed_main_page.release_text".tr(),
          completeText: "feed_main_page.complete_text".tr(),
          refreshingText: "feed_main_page.refreshing_text".tr(),
          idleText: "feed_main_page.idle_text".tr(),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          key: const PageStorageKey(0),
          itemBuilder: (contex, index) {
            return index >= widget.cats.length - 1
                ? const ProgressBar()
                : FeedListItem(
                    cat: widget.cats[index],
                  );
          },
          controller: _controller,
          itemCount: widget.cats.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 30,
            );
          },
        ));
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onScroll() {
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
