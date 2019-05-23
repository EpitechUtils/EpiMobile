import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class IntranetAPIUtils {

    // make this class singleton
    static IntranetAPIUtils _instance = new IntranetAPIUtils.internal();
    IntranetAPIUtils.internal();
    factory IntranetAPIUtils() => _instance;

    String _baseUrl = "https://intra.epitech.eu";
    NetworkUtils _network = new NetworkUtils();

    /// Get authentication url from login page
    Future<dynamic> getAuthURL() {
        return this._network.get(this._baseUrl + "?format=json");
    }

    /// Login from redirect URI
    // ignore: avoid_init_to_null
    Future<bool> loginFromRedirectUri(String redirectUrl, {Cookie cookie: null}) async {
        dynamic res = await this._network.get(redirectUrl, cookie: cookie);

        if (res == null)
            return false;
        return true;
    }

    /// Get and save autoLogin URI from URL
    // ignore: avoid_init_to_null
    Future<dynamic> getAndSaveAutologinLink(String redirectUrl, {Cookie cookie: null}) async {
        bool success = await this.loginFromRedirectUri(redirectUrl, cookie: cookie);
        if (!success)
            return null;

        // Check if url is available
        return this._network.get(this._baseUrl + "/admin/autolog?format=json")
            .then((res) {
            debugPrint("Autolog redirect: " + res.toString());
            if (res == null)
                return null;

            return res;
        });
    }

    Future<dynamic> get(String url) async {
        var cacheManager = await CacheManager.getInstance();

        return await cacheManager.getFile(url);
    }
}
