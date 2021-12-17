import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class CatSearchState {
  final List<String> availableTags;
  final List<Cat> cats;
  final List<String> searchTags;
  final bool canLoadMore;
  final bool isError;

  const CatSearchState({
    this.availableTags = const [],
    this.cats = const [],
    this.searchTags = const [],
    this.canLoadMore = true,
    this.isError = false,
  });

  CatSearchState copyWith({
    List<String>? availableTags,
    List<Cat>? cats,
    List<String>? searchTags,
    bool? canLoadMore,
    bool? isError,
  }) {
    return CatSearchState(
      availableTags: availableTags ?? this.availableTags,
      cats: cats ?? this.cats,
      searchTags: searchTags ?? this.searchTags,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      isError: isError ?? this.isError,
    );
  }
}

class CatSearchBloc extends Cubit<CatSearchState>{
  CatSearchBloc([CatSearchState initialState = const CatSearchState()]) : super(initialState){
    updateAvailableTags();
    loadMoreCats(10);
  }

  Future<void> updateAvailableTags() async {
    try{
      final tags = await GetIt.I<CatRepository>().getAllTags();
      emit(state.copyWith(availableTags: tags));
    }catch(_){
      emit(state.copyWith(isError: true));
    }

  }

  void refresh(){
    emit(state.copyWith(isError: false));
    updateAvailableTags();
    setSearchTags(state.searchTags);
  }

  void setSearchTags(List<String> tags){
    emit(state.copyWith(searchTags: tags, cats: [], canLoadMore: true, isError: false));
    loadMoreCats(10);
  }

  void loadMoreCats(int count) async{
    if(!state.canLoadMore) return;
    final oldState = state;
    try{
      final cats = await GetIt.I<CatRepository>().getAllCatsByTag(tags: state.searchTags, limitNumberOfCats: count, numberOfCatsToSkip: state.cats.length);
      if(state.cats == oldState.cats) {
        emit(state.copyWith(cats: state.cats + cats, canLoadMore: cats.isNotEmpty));
      } else {
        Logger().i("load more cats finished after update");
      }
    }catch(_){
      emit(state.copyWith(isError: true));
    }

  }

}