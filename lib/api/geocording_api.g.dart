// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocording_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GeocordingApi implements GeocordingApi {
  _GeocordingApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://aginfo.cgk.affrc.go.jp';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Address> geocording(latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': latitude,
      r'lon': longitude
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Address>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/ws/rgeocode.php?json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Address.fromJson(_result.data!);
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
