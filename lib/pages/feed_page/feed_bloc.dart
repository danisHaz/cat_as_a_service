import 'package:dio/dio.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_data.dart';
import 'package:flutter_basics_2/pages/feed_page/feed_data_state.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class FeedCubit extends Cubit<FeedDataState<dynamic>> {
  FeedCubit({bool? isLoading}): super(
    FeedDataState(
      isLoading: isLoading ?? false,
      isUpdateRequired: true,
    )
  );

  final FeedPageData _data = FeedPageData();
  List<Cat> get cats => _data.cats;
  set cats(List<Cat> catsList) {
    _data.cats.clear();
    _data.cats.addAll(catsList);
  }

  void addCat(Cat cat) {
    _data.cats.add(cat);
  }

  void addCats(List<Cat> cat) {
    _data.cats.addAll(cats);
  }

  Future<void> refreshCats({
    required int numberOfCatsInPage,
  }) async {
    _data.cats.clear();
    await getListOfCatsAsPage(
      numberOfCatsInPage: numberOfCatsInPage,
    );
  }

  Future<void> getListOfCatsAsPage({
    required int numberOfCatsInPage,
  }) async {
    emit(const FeedDataState(isLoading: true));

    try {
      for (int i = 0; i < numberOfCatsInPage; i++) {
        _data.cats.add(
          await CatRepository().getRandomCat()
        );
      }
      emit(FeedDataState<List<Cat>>(isLoading: false, data: _data.cats));
    } on DioError catch(err) {
      Logger().d(err);
      emit(FeedDataState(isLoading: false, err: Error()));
    } catch (err) {
      // Logger().d(err);
      emit(FeedDataState(isLoading: false, err: err as Error));
    }

    // data collected or error is thrown

  }
}