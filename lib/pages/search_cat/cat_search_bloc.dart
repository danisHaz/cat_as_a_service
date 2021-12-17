import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class CatSearchState {
  final List<String> available_tags;
  final List<Cat> cats;
  final List<String> search_tags;
  final bool canLoadMore;

  const CatSearchState({
    this.available_tags = const [],
    this.cats = const [],
    this.search_tags = const [],
    this.canLoadMore = true,
  });

  CatSearchState copyWith({
    List<String>? available_tags,
    List<Cat>? cats,
    List<String>? search_tags,
    bool? canLoadMore,
  }) {
    return CatSearchState(
      available_tags: available_tags ?? this.available_tags,
      cats: cats ?? this.cats,
      search_tags: search_tags ?? this.search_tags,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

class CatSearchBloc extends Cubit<CatSearchState>{
  CatSearchBloc([CatSearchState initialState = const CatSearchState()]) : super(initialState){
    GetIt.I<CatRepository>().getAllTags().then((tags) {
      emit(state.copyWith(available_tags: tags));
      loadMoreCats(10);
    });
  }

  

  void setSearchTags(List<String> tags){
    emit(state.copyWith(search_tags: tags, cats: [], canLoadMore: true));
    loadMoreCats(10);
  }

  void loadMoreCats(int count) async{
    if(!state.canLoadMore) return;
    final oldState = state;
    final cats = await GetIt.I<CatRepository>().getAllCatsByTag(tags: state.search_tags, limitNumberOfCats: count, numberOfCatsToSkip: state.cats.length);
    if(state == oldState) {
      emit(state.copyWith(cats: state.cats + cats, canLoadMore: cats.isNotEmpty));
    } else {
      Logger().i("load more cats finished after update");
    }
  }

}