import 'dart:developer';

import 'package:flutter_basics_2/pages/feed_page/feed_data_state.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCubit extends Cubit<FeedDataState<dynamic>> {
  FeedCubit({bool? isLoading}): super(
    FeedDataState(
      isLoading: isLoading ?? false,
      isUpdateRequired: true,
    )
  );

  final Cat kekingCat = const Cat(
    id: "5e2b4b634348da001c78fb7d",
    createdAt: "2020-01-24T19:54:11.511Z",
    tags: [],
    url: "/cat/5e2b4b634348da001c78fb7d"
  );

  Future<void> getListOfCatsAsPage({
    required int numberOfCatsInPage,
  }) async {
    emit(const FeedDataState(isLoading: true));
    log("wqewqweqe");

    // go to repository and get data

    final List<Cat> kitties = [];
    for (int i = 0; i < numberOfCatsInPage; i++) {
      kitties.add(kekingCat);
    }

    // data collected or error is thrown

    emit(FeedDataState<List<Cat>>(isLoading: false, data: kitties));
  }
}