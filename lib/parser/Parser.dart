import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:mobile_intranet/parser/components/Profile/Profile.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/Profile/Netsoul/Netsoul.dart';
import 'package:mobile_intranet/parser/components/subcomponents/moduleProject/ModuleProject.dart';

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
    Future<Dashboard> parseDashboard() async {
        dynamic dashboard = await this._network.get(autolog + "/?format=json");
        if (dashboard == null)
            return null;

        return Dashboard.fromJson(dashboard["board"]);
    }

    Future<Netsoul> parseNetsoul(String login) async {
        String url = autolog + "/user/" + login + "/netsoul";

        dynamic netsoul = await this._network.get(url);
        if (netsoul == null)
            return null;
        return Netsoul(netsoul);
    }

    Future<ModuleProject> parseModuleProject(String login, String slug) async {
        String url = autolog + slug + "project/?format=json";

        dynamic moduleProject = await this._network.get(url);
        if (moduleProject == null)
            return null;
        print(moduleProject);
        return ModuleProject.fromJson(moduleProject);
    }
}