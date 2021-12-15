import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_editor.dart';
import 'package:flutter_basics_2/pages/search_cat/cat_search_bloc.dart';
import 'package:flutter_basics_2/pages/search_cat/suggestions.dart';
import 'package:flutter_basics_2/shared/colors.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchbar(),
                    Wrap(
                      spacing: 3,
                      runSpacing: 3,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      children: tags
                          .map((e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: backgroundGrey,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Material(
                                type: MaterialType.transparency,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        e,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Container(width: 10),
                                      IconButton(
                                          padding: const EdgeInsets.all(0),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          onPressed: () {
                                            setState(() {
                                              tags.removeWhere(
                                                  (element) => element == e);
                                            });
                                            context.read<CatSearchBloc>()
                                              ..setSearchTags(tags)
                                              ..loadMoreCats(10);
                                            _textController.clear();
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                ),
                              )))
                          .toList(),
                    ),
                    Container(height: 8),
                    Flexible(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: _scrollController,
                        key: const PageStorageKey(2),
                        slivers: [
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.8,
                              crossAxisCount:
                                  MediaQuery.of(context).size.width ~/ 150,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == state.cats.length - 1) {
                                  context
                                      .read<CatSearchBloc>()
                                      .loadMoreCats(10);
                                }
                                return CatPreview(
                                  heroTag: catHeroTag(cat: state.cats[index]),
                                  cat: state.cats[index],
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CatEditorPage(
                                                heroTag: catHeroTag(
                                                    cat: state.cats[index]),
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
                      ),
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
                  options: state.available_tags
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

  Widget _buildSearchbar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        key: searchbarKey,
        enabled: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          fillColor: backgroundGrey,
          filled: true,
          hintText: 'Enter tag...',
          contentPadding: EdgeInsets.all(15),
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
