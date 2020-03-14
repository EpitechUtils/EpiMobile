import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {

    /// make this class singleton
    static NetworkUtils _instance = new NetworkUtils.internal();
    NetworkUtils.internal();
    factory NetworkUtils() {
        _instance.dio.interceptors.add(_instance.cacheManager.interceptor);

        return _instance;
    }

    HttpClient _client = HttpClient();
    JsonDecoder _gson = new JsonDecoder();

    DioCacheManager cacheManager = DioCacheManager(CacheConfig(baseUrl: "https://intra.epitech.eu"));
    final Dio dio = Dio(BaseOptions(
        baseUrl: "https://intra.epitech.eu",
        connectTimeout: 20000,
        receiveTimeout: 20000,
        validateStatus: (status) => status < 500
    ));

    dynamic get(String url, {String bearer, Duration cacheDuration}) async {
        print(url);
        if (cacheDuration == null)
            cacheDuration = Duration(minutes: 5);

        try {
            Response response = await this.dio.get(url,
                options: buildCacheOptions(cacheDuration,
                    options: Options(
                        headers: () {
                            if (bearer == null) {
                                return {
                                    'Accept': "application/json",
                                    'Content-Type': "application/json",
                                };
                            }

                            // Add authorization token
                            return {
                                'Accept': "application/json",
                                'Content-Type': "application/json",
                                'Authorization': 'Bearer ' + bearer
                            };
                        }(),
                        responseType: ResponseType.json,
                        followRedirects: true,
                        receiveDataWhenStatusError: true
                    ),
                    maxStale: Duration(days: 10)
                ));

            dynamic body = response.data;
            if (body == null || response.statusCode >= 500)
                return null;

            return body;
        } catch (error) {
            print(error);
            return null;
        }
    }

    dynamic post(String url, Map jsonMap) async {
        String response = await this.dio.post(url,
            data: jsonMap,
            options: Options(
                contentType: 'application/json',
                responseType: ResponseType.json,
                followRedirects: true,
            )).then((Response value) {
                String body = value.data;
                if (body == null || body.isEmpty || value.statusCode >= 500)
                    return null;

                return body;
            });

        return response;
    }

}