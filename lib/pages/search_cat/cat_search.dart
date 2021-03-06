import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_editor.dart';
import 'package:flutter_basics_2/pages/search_cat/cat_search_bloc.dart';
import 'package:flutter_basics_2/pages/search_cat/suggestions.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatSearchPage extends StatefulWidget {
  const CatSearchPage({Key? key}) : super(key: key);

  @override
  CatSearchPageState createState() => CatSearchPageState();
}

class CatSearchPageState extends State<CatSearchPage> {
  final ScrollController _scrollController = ScrollController();
  final searchbarKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  List<String> tags = [];
  bool suggestionsVisible = false;
  FocusNode node = FocusNode();

  @override
  void dispose() {
    _scrollController.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    node.addListener(() {
      setState(() {
        suggestionsVisible = node.hasFocus;
      });
    });
  }

  // TODO: keep scrolling position when changing page
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatSearchBloc, CatSearchState>(
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchbar(context),
                    Wrap(
                      spacing: 3,
                      runSpacing: 3,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      children: tags
                          .map((e) => Chip(
                                deleteIcon: const Icon(Icons.close),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(10),
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                label: Text(
                                  e,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                onDeleted: () => setState(() {
                                  tags.removeWhere((element) => element == e);
                                  context.read<CatSearchBloc>()
                                    ..setSearchTags(tags)
                                    ..loadMoreCats(10);
                                  _textController.clear();
                                }),
                              ))
                          .toList(),
                    ),
                    Container(height: 8),
                    Flexible(
                      child: !state.isError
                          ? _buildGrid(context, state)
                          : _buildErrorButton(context, state),
                    ),
                  ],
                ),
              ),
              if (suggestionsVisible)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      node.unfocus();
                    });
                  },
                ),
              Visibility(
                visible: suggestionsVisible,
                child: Suggestions(
                  input: _textController.text,
                  selectOption: (String option) {
                    setState(() {
                      tags.add(option);
                      node.unfocus();
                    });
                    context.read<CatSearchBloc>()
                      ..setSearchTags(tags)
                      ..loadMoreCats(10);
                    _textController.clear();
                  },
                  parentKey: searchbarKey,
                  options: state.availableTags
                      .where((element) => !tags.contains(element))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorButton(BuildContext context, CatSearchState state) {
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
              context.read<CatSearchBloc>().refresh();
            },
            child: Text('refresh'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, CatSearchState state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: _scrollController,
      key: const PageStorageKey(2),
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == state.cats.length - 1) {
                context.read<CatSearchBloc>().loadMoreCats(10);
              }
              return CatPreview(
                heroTag: catHeroTag(cat: state.cats[index]),
                cat: state.cats[index],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CatEditorPage(
                          heroTag: catHeroTag(cat: state.cats[index]),
                          cat: state.cats[index])));
                },
              );
            },
            childCount: state.cats.length,
          ),
        ),
        if (state.canLoadMore)
          const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        // const SliverFillRemaining(),
      ],
    );
  }

  Widget _buildSearchbar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        key: searchbarKey,
        enabled: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: true,
          hintText: 'cat_search.enter_tag'.tr(),
          contentPadding: const EdgeInsets.all(15),
          isCollapsed: true,
        ),
        controller: _textController,
        style: const TextStyle(fontSize: 18),
        onChanged: (value) {
          setState(() {});
        },
        focusNode: node,
      ),
    );
  }
}
