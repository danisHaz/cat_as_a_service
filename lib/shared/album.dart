import 'package:flutter_basics_2/shared/cat.dart';

class Album{
  final int id;
  final String name;
  final List<Cat> cats;
  Album(
      this.id,
      this.name,
      this.cats,
      );
}