import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtils {

    /// make this class singleton
    static NetworkUtils _instance = new NetworkUtils.internal();
    NetworkUtils.internal();
    factory NetworkUtils() => _instance;

    final JsonDecoder _gson = new JsonDecoder();

    Future<dynamic> get(String url) {
        var response = http.get(
            Uri.encodeFull(url),
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            }
        );

        // Process response
        return response.then((http.Response response) {
            final String body = response.body;
            final int statusCode = response.statusCode;

            // Check state
            if (statusCode < 200 || statusCode > 401 || body == null)
                return null;

            return _gson.convert(body);
        });
    }

}