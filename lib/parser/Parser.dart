import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:mobile_intranet/parser/components/Profile.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';

/// Parser class
class Parser {
    String autolog;
    NetworkUtils _network = new NetworkUtils();

    /// Constructor
    Parser(String autolog) {
        this.autolog = autolog;
    }

    /// Parse profile
    Future<Profile> parseProfile(String login) async {
        String url = autolog + "/user/" + login + "/print";
        // Used for tests
        //String url = login + "/user/lucas.gras@epitech.eu/print";

        dynamic profile = await this._network.get(url);
        if (profile == null)
            return null;

        Profile profileClass = Profile.fromJson(profile);
        List listGhost = profileClass.flags["ghost"]["modules"];
        List listDifficulty = profileClass.flags["difficulty"]["modules"];
        List listRemarkable = profileClass.flags["remarkable"]["modules"];
        List listMedal = profileClass.flags["medal"]["modules"];

        profileClass.ghostLen = listGhost.length;
        profileClass.difficultyLen = listDifficulty.length;
        profileClass.remarkableLen = listRemarkable.length;
        profileClass.medalLen = listMedal.length;

        return profileClass;
    }

    /// Parse dashboard info
    Future<Dashboard> parseDashboard() {
        return NetworkUtils.internal().get(autolog).then((data) {
            if (data == null)
                return null;
            return Dashboard(data);
        });
    }
}