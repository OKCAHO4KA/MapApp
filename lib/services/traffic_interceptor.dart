import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1Ijoib3hhbmExOTgwIiwiYSI6ImNsazdhcDkwczA3YjAzZ3JvZzh6ZHlxZ2wifQ.GShV1B_vWE7ZES6EK4tSCA';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken,
    });

    super.onRequest(options, handler);
  }
}
