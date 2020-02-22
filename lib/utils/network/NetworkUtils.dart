import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {

    /// make this class singleton
    static NetworkUtils _instance = new NetworkUtils.internal();
    NetworkUtils.internal();
    factory NetworkUtils() => _instance;

    HttpClient _client = HttpClient();
    JsonDecoder _gson = new JsonDecoder();

    // ignore: avoid_init_to_null
    dynamic get(String url, {Cookie cookie: null, String bearer: null}) async {
        String response = await this._client.getUrl(Uri.parse(url))
            .then((HttpClientRequest req) {
            req.followRedirects = true;

            // Set headers
            req.headers.set("Content-Type", "application/json");
            req.headers.set("Accept", "application/json");
            
            if (bearer != null) {
                req.headers.set("Authorization", "Bearer " + bearer);
            }

            // Set cookies if not null
            if (cookie != null) {
                req.cookies.add(cookie);
            }

            // Close request configuration
            return req.close();
        }).then((HttpClientResponse response) async {
            String body = await response.transform(utf8.decoder).join();

            if (body == null || body.isEmpty || response.statusCode >= 500)
                return null;

            return body;
        });

        //debugPrint(response.toString());
        if (response == null)
            return null;
        dynamic res = this._gson.convert(response);
        return res;
    }

    dynamic post(String url, Map jsonMap, {Cookie cookie: null}) async {

        dynamic response = await http.post(
            url,
            headers: {"Content-Type": "application/json"},
            body: json.encode(jsonMap)
        );
        return response.body;
    }

}