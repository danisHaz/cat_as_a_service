import 'package:flutter_basics_2/pages/feed_page/feed_data_state.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCubit extends Cubit<FeedDataState<dynamic>> {
  FeedCubit({bool? isLoading}): super(
    FeedDataState(
      isLoading: isLoading ?? false,
      isUpdateRequired: true,
    )
  );

  Future<void> getListOfCatsAsPage({
    required int numberOfCatsInPage,
  }) async {
    emit(const FeedDataState(isLoading: true));

    final List<Cat> kitties = [];
    for (int i = 0; i < numberOfCatsInPage; i++) {
      kitties.add(
        await CatRepository().getRandomCat()
      );
    }

    // data collected or error is thrown

    emit(FeedDataState<List<Cat>>(isLoading: false, data: kitties));
  }
}