import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:mobile_intranet/parser/components/Profile.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';

class Parser {

    String autolog;

    Parser({String autolog});

    Future<Profile> parseProfile(String login) {
        String url = autolog + "/user/" + login + "/print";
        // Used for tests
        //String url = login + "/user/lucas.gras@epitech.eu/print";

        return NetworkUtils.internal().get(url).then((data) {
            if (data == null)
                return null;
            return Profile.fromJson(data);
        });
    }

    Future<Dashboard> parseDashboard() {
        String url = autolog;

        print(url);
        return NetworkUtils.internal().get(url).then((data) {
            if (data == null)
                return null;
            return Dashboard(data);
        });
    }
}