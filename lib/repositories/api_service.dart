import 'package:dio/dio.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/cat")
  Future<Cat> getCatJsonData({
    @Query("json") bool getJson = true
  });

  @GET("/api/cats")
  Future<List<Cat>> getAllCatsByTag({
    @Query("tags") required String formattedTags,
    @Query("skip") required int numberOfCatsToSkip,
    @Query("limit") required int limitNumberOfCats
  });

  @GET("/api/tags")
  Future<List<String>> getAllTags();

  @GET("/cat/says/{words}")
  Future<Cat> getFilteredRandomCat({
    @Query("filter") required String filter,
    @Query("color") required String textColor,
    @Query("size") required String fontSize,
    @Query("type") required String type,
  });

  @GET("/cat/{url}")
  Future<Cat> getFilteredSpecifiedCat({
    @Query("filter") required String filter,
    @Query("color") required String textColor,
    @Query("size") required String fontSize,
    @Query("type") required String type,
    @Path("id") required String id,
  });
}