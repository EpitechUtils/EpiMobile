import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:mobile_intranet/parser/components/Profile.dart';

class Parser {

    // Replace this link to the origin url (https://intra.epitech.eu)
    String _baseUrl = "https://intra.epitech.eu/auth-26897161882b1b6ae036add2878a64f97daf57fa";

    Future<Profile> parseProfile(String login) {
        String url = _baseUrl + "/user/" + login + "/print";
        // Used for tests
        //String url = login + "/user/lucas.gras@epitech.eu/print";

        return NetworkUtils.internal().get(url, true).then((data) {
                if (data == null)
                    return null;
                return Profile.fromJson(data);
        });
    }
}