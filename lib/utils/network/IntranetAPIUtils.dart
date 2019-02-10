import 'package:mobile_intranet/utils/network/NetworkUtils.dart';

class IntranetAPIUtils {

    // make this class singleton
    static IntranetAPIUtils _instance = new IntranetAPIUtils.internal();
    IntranetAPIUtils.internal();
    factory IntranetAPIUtils() => _instance;

    String _baseUrl = "https://intra.epitech.eu";
    NetworkUtils _network = new NetworkUtils();

    Future<dynamic> getAuthURL() {
        return this._network.get(this._baseUrl + "?format=json", true);
    }

    Future<bool> loginFromRedirectUri(String redirectUrl) {
        Future<dynamic> request = this._network.get(redirectUrl, false);

        // Request
        return request.then((res) {
            if (res == null)
                return false;

            return true;
        });
    }

    Future<bool> getAndSaveAutologinLink(String redirectUrl) {
        Future<bool> redirectLogin = this.loginFromRedirectUri(redirectUrl);

        // Check if url is availale
        return redirectLogin.then((bool res) async {
            if (!res)
                return false;

            dynamic autologin = await this._network.get(this._baseUrl + "?format=json", true);
            if (autologin == null)
                return false;

            return true;
        });
    }
}
