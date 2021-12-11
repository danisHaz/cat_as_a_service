import 'package:dio/dio.dart';
import 'package:flutter_basics_2/shared/models/cat_json_data.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/cat")
  Future<CatJsonData> getCatJsonData({
    @Query("json") bool getJson = true
  });

  @GET("/api/cats")
  Future<List<CatJsonData>> getAllCatsByTag({
    @Query("tags") required String formattedTags,
    @Query("skip") required int numberOfCatsToSkip,
    @Query("limits") required int limitNumberOfCats
  });

}