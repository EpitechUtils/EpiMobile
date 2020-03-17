import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mobile_intranet/utils/network/networkUtils.dart';
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
        return this._network.get(this._baseUrl + "/admin/autolog?format=json");
    }

    /// Get and save autoLogin URI from URL
    // ignore: avoid_init_to_null
    Future<dynamic> getLoggedUserEmail(String autolog) async {
        // Check if url is available
        return this._network.get(autolog + "/user").then((res) {
            if (res == null || res['login'] == null)
                return null;

            return res["login"];
        });
    }

    Future<dynamic> registerToProject(String url, String name, List<String> team) async {
        Map jsonMap = {};

        if (name != null)
            jsonMap["title"] = name;
        if (team != null)
            jsonMap["members"] = team;

        return this._network.post(url, jsonMap).then((res) {
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
            if (res == null)
                return null;

            return res;
        });
    }

    Future<dynamic> registerToActivity(String autolog, String year, String codeModule, String codeInstance, String codeActi, bool register) async {
        String url = autolog + "/module/" + year + "/" + codeModule + "/" + codeInstance + "/" + codeActi;

        if (register)
            url += "/register?format=json";
        else
            url += "/unregister?format=json";

        return this._network.post(url, {}).then((res) {
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
