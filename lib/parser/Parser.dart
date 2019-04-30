import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:mobile_intranet/parser/components/Profile.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';

class Parser {

    // make this class singleton
    static Parser _instance = new Parser.internal();
    Parser.internal();
    factory Parser() => _instance;

    // Replace this link to the origin url (https://intra.epitech.eu)
    String _baseUrl = "https://intra.epitech.eu/auth-96f531fac15a3d5bc48370697c7151b5d35af498";

    Future<Profile> parseProfile(String login) {
        String url = _baseUrl + "/user/" + login + "/print?format=json";
        // Used for tests
        //String url = login + "/user/lucas.gras@epitech.eu/print";

        return NetworkUtils.internal().get(url, true).then((data) {
            if (data == null)
                return null;
            return Profile.fromJson(data);
        });
    }

    Future<Dashboard> parseDashboard() {
        String url = _baseUrl +"/?format=json";

        print(url);
        return NetworkUtils.internal().get(url, true).then((data) {
            if (data == null)
                return null;
            return Dashboard(data);
        });
    }
}