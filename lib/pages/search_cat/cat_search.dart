import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_editor.dart';
import 'package:flutter_basics_2/pages/search_cat/cat_search_bloc.dart';
import 'package:flutter_basics_2/utils/hero_tags.dart';
import 'package:flutter_basics_2/widgets/cat_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class CatSearchPage extends StatefulWidget {
  const CatSearchPage({Key? key}) : super(key: key);

  @override
  CatSearchPageState createState() => CatSearchPageState();
}

class CatSearchPageState extends State<CatSearchPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // TODO: keep scrolling position when changing page
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatSearchBloc, CatSearchState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChipsInput(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Search tags"
                  ),
                  initialValue: state.search_tags,
                  findSuggestions: (String query) {
                    if (query.isEmpty) return <String>[];
                    return state.available_tags
                        .where((tag) =>
                            tag.toLowerCase().contains(query.toLowerCase()))
                        .toList(growable: false)
                      ..sort((a, b) => a
                          .toLowerCase()
                          .indexOf(query.toLowerCase())
                          .compareTo(
                              b.toLowerCase().indexOf(query.toLowerCase())));
                  },
                  onChanged: (List<String> value) {
                    context.read<CatSearchBloc>()
                      ..setSearchTags(value)
                      ..loadMoreCats(10);
                  },
                  suggestionBuilder: (BuildContext context,
                      ChipsInputState<String> state, String data) {
                    return ListTile(
                      title: Text(data),
                      onTap: () => state.selectSuggestion(data),
                    );
                  },
                  chipBuilder: (BuildContext context,
                      ChipsInputState<String> state, String data) {
                    return InputChip(
                      label: Text(data),
                      // onPressed: (){
                      //   state.deleteChip(data);
                      // },
                      deleteIcon: const Icon(Icons.highlight_off),
                      onDeleted: () {
                        state.deleteChip(data);
                      },
                    );
                  },
                ),
              ),
              Flexible(
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  controller: _scrollController,
                  key: const PageStorageKey(2),
                  slivers: [
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width ~/ 100,
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
                            Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => CatEditorPage(
                                    heroTag: catHeroTag(cat: state.cats[index]),
                                    cat: state.cats[index]
                                  )
                                )
                              );
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
        );
      },
    );
  }
}
