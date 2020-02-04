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
        return this._network.get(this._baseUrl);
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
        return this._network.get(this._baseUrl + "/admin/autolog")
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

    Future<dynamic> registerToProject(String url, String name, List<String> team) async {
        Map jsonMap = {};

        if (name != null)
            jsonMap["title"] = name;
        if (team != null)
            jsonMap["members"] = team;

        return this._network.post(url, jsonMap).then((res) {
            debugPrint("Autolog redirect: " + res.toString());
            if (res == null)
                return null;

            return res;
        });
    }

    Future<dynamic> unregisterToProject(String url, String projectName, String codeInstance, String email) async {
        Map jsonMap = {};
        String code = projectName.replaceAll(' ', '-') + "-" + codeInstance + "-" + email;

        jsonMap["code"] = code;

        return this._network.post(url, jsonMap).then((res) {
            debugPrint("Autolog redirect: " + res.toString());
            if (res == null)
                return null;

            return res;
        });
    }

    Future<dynamic> registerToRdvSlot(String url, int idTeam, int idSlot) async {
        Map jsonMap = {};

        jsonMap["id_creneau"] = idSlot.toString();
        jsonMap["id_team"] = idTeam.toString();
        return this._network.post(this._baseUrl + "/" + url, jsonMap).then((res) {
            debugPrint("Autolog redirect: " + res.toString());
            if (res == null)
                return null;

            return res;
        });
    }
}
