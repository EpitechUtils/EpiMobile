import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NetworkUtils {

    /// make this class singleton
    static NetworkUtils _instance = new NetworkUtils.internal();
    NetworkUtils.internal();
    factory NetworkUtils() => _instance;

    http.Client _client = new http.Client();
    JsonDecoder _gson = new JsonDecoder();

    Future<dynamic> get(String url, bool jsonFormat) {
        Future<http.Response> response = this._client.get(
            url,
            headers: jsonFormat ? {
                "Accept": "application/json",
                "Content-Type": "application/json"
            } : {}
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
        });
    }

}