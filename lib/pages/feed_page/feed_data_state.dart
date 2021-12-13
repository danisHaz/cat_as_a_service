import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/shared/cat.dart';

extension ErrorPrint on Error? {
  void print() {
    log(this?.stackTrace?.toString() ?? "No stacktrace for this error");
  }
}

@immutable
class FeedDataState<T> {
  final Error? err;
  final bool isLoading;
  final bool? isUpdateRequired;
  final List<Cat>? data;

  const FeedDataState({
    this.err,
    required this.isLoading,
    this.isUpdateRequired,
    this.data,
  });

  FeedDataState copyWith({
    Error? err,
    required bool isLoading,
    bool? isUpdateRequired,
    bool? isSuccessful
  }) {
    return FeedDataState(
      isLoading: isLoading,
      err: err,
      isUpdateRequired: isUpdateRequired,
      data: data,
    );
  }
}