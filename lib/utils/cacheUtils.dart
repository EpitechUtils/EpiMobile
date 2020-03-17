import 'package:shared_preferences/shared_preferences.dart';

class CacheUtils {

    // make this class singleton
    static CacheUtils _instance = new CacheUtils.internal();
    CacheUtils.internal();
    factory CacheUtils() => _instance;

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<bool> setString(String key, String value) async {
        SharedPreferences pref = await this._prefs;

        // Set string
        return await pref.setString(key, value);
    }

    Future<bool> setBool(String key, bool value) async {
        SharedPreferences pref = await this._prefs;

        // Set boolean
        return await pref.setBool(key, value);
    }

    Future<bool> setInt(String key, int value) async {
        SharedPreferences pref = await this._prefs;

        // Set integer
        return await pref.setInt(key, value);
    }

    Future<bool> setStringList(String key, List<String> value) async {
        SharedPreferences pref = await this._prefs;

        // Set list of strings
        return await pref.setStringList(key, value);
    }

    Future<dynamic> get(String key) async {
        SharedPreferences pref = await this._prefs;

        // Get data stored (dynamic type)
        return await pref.get(key);
    }

}