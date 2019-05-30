import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class NetworkUtils {

    /// make this class singleton
    static NetworkUtils _instance = new NetworkUtils.internal();
    NetworkUtils.internal();
    factory NetworkUtils() => _instance;

    HttpClient _client = HttpClient();
    JsonDecoder _gson = new JsonDecoder();

    // ignore: avoid_init_to_null
    dynamic get(String url, {Cookie cookie: null}) async {
        String response = await this._client.getUrl(Uri.parse(url))
            .then((HttpClientRequest req) {
            req.followRedirects = true;

            // Set headers
            req.headers.set("Content-Type", "application/json");
            req.headers.set("Accept", "application/json");

            // Set cookies if not null
            if (cookie != null) {
                req.cookies.add(cookie);
                req.cookies.forEach((ck) { debugPrint("------------ " + ck.toString()); });
            }

            // Close request configuration
            return req.close();
        }).then((HttpClientResponse response) async {
            String body = await response.transform(utf8.decoder).join();

            if (body == null || body.isEmpty || response.statusCode >= 500)
                return null;

            return body;
        });

        debugPrint("Result for: " + Uri.parse(url).toString());
        //debugPrint(response.toString());
        if (response == null)
            return null;
        dynamic res = this._gson.convert(response);
        return res;




        /*Future<http.Response> response = this._client.get(
            url,
            headers: jsonFormat ? {
                "Accept": "application/json",
                "Content-Type": "application/json"
            } : {},
        );

        // Process response
        return response.then((http.Response response) {
            final String body = response.body;

            // TODO: Debugger
            //debugPrint(body);
            print("Result networkUtils => " + body);

            // Check body content
            if (body == null || body.isEmpty || response.statusCode >= 500)
                return null;

            return jsonFormat ? _gson.convert(body) : body;
        });*/
    }

}