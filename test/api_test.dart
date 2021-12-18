import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_basics_2/repositories/cat_repository.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCatRepository {
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  int _counter = 0;

  String _getNewId() => (_counter++).toString();

  Cat getRandomCat() {
    return Cat(
      id: _getNewId(),
      tags: [_getRandomString(10)],
    );
  }

  Cat getRandomCatWithFullParams() =>
    Cat(
      id: _getNewId(),
      tags: [_getRandomString(10)],
      textColor: null,
      text: null,
      fontSize: null,
      filter: null,
      height: null,
      width: null,
      type: "",
    );

  Cat getCatWithAdditionalParams({
    String? textColor,
    String? text,
    double? fontSize,
    CatDecorationFilter? filter,
    double? height,
    double? width,
  }) {
    return (getRandomCatWithFullParams()).copyWith(
      textColor: textColor,
      text: text,
      fontSize: fontSize,
      filter: filter,
      height: height,
      width: width,
    );
  }
}
class ApiData {
  late List<Cat> cats = [];
  int catsNumber = 100;

  void initData() {
    for (int i = 0; i < catsNumber; ++i) {
      cats.add(FakeCatRepository().getRandomCat());
    }
  }

}

void main() {
  test("ApiData should have 100 cats appropriately", () {
    final apiData = ApiData();
    apiData.initData();

    expect(apiData.cats.length, apiData.catsNumber);
  });

}