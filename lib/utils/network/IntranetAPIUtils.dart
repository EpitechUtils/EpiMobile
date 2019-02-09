import 'package:mobile_intranet/utils/network/NetworkUtils.dart';

class IntranetAPIUtils {

    final String baseUrl;
    final NetworkUtils _network = new NetworkUtils();

    IntranetAPIUtils({this.baseUrl = "https://intra.epitech.eu/"});

    Future<dynamic> getAuthURL() {
        return this._network.get(this.baseUrl);
    }
}
