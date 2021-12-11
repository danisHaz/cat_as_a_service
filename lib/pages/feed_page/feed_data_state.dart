import 'dart:developer';

import 'package:flutter/widgets.dart';

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
  final bool? isSuccessful;

  const FeedDataState({
    this.err,
    required this.isLoading,
    this.isUpdateRequired,
    this.isSuccessful
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
      isSuccessful: isSuccessful
    );
  }
}