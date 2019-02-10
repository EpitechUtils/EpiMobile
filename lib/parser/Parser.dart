import '../utils/network/NetworkUtils.dart' as network;
import 'components/Profile.dart';

class Parser {

    final String _baseUrl = "https://intra.epitech.eu";

    Future<Profile> parseProfile(String login) {
        String url = _baseUrl + "/user/" + login + "/print";
        // Used for tests
        //String url = login + "/user/lucas.gras@epitech.eu/print";

        return network.NetworkUtils.internal().get(url).then((data) {
                if (data == null)
                    return null;
                return Profile.fromJson(data);
        });
    }
}