// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://cataas.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CatJsonData> getCatJsonData({getJson = true}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'json': getJson};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CatJsonData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/cat',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CatJsonData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<CatJsonData>> getAllCatsByTag(
      {required formattedTags,
      required numberOfCatsToSkip,
      required limitNumberOfCats}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'tags': formattedTags,
      r'skip': numberOfCatsToSkip,
      r'limits': limitNumberOfCats
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<CatJsonData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/cats',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => CatJsonData.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
