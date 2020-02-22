import 'package:mobile_intranet/utils/network/NetworkUtils.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/BoardModule.dart';
import 'package:mobile_intranet/parser/components/dashboard/module/ModuleInformation.dart';
import 'package:mobile_intranet/parser/components/profile/Netsoul/Netsoul.dart';
import 'package:mobile_intranet/parser/components/subcomponents/moduleProject/ModuleProject.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlots.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';
import 'package:mobile_intranet/parser/components/epitest/result.dart';
import 'package:intl/intl.dart';

import 'components/epitest/results.dart';

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

    /// Parse dashboard projects and modules info
    Future<Dashboard> parseDashboard() async {
        dynamic dashboard = await this._network.get(autolog + "/?format=json");
        if (dashboard == null)
            return null;

        return Dashboard.fromJson(dashboard["board"]);
    }

    /// Parse dashboard recent notifications
    Future<Notifications> parseDashboardNotifications() async {
        dynamic notifications = await this._network.get(autolog + "/?format=json");
        if (notifications == null)
            return null;

        return Notifications.fromJson(notifications);
    }

    Future<Netsoul> parseNetsoul(String login) async {
        String url = autolog + "/user/" + login + "/netsoul";

        dynamic netsoul = await this._network.get(url);
        if (netsoul == null)
            return null;
        return Netsoul(netsoul);
    }

    Future<ModuleProject> parseModuleProject(String slug) async {
        String url = autolog + slug + "project/?format=json";

        dynamic moduleProject = await this._network.get(url);
        if (moduleProject == null)
            return null;

        ModuleProject moduleProjectClass = ModuleProject.fromJson(moduleProject);
        String urlFile = autolog + slug + "project/file";
        dynamic fileHtml = await this._network.get(urlFile);
        print(fileHtml.toString());

        if (fileHtml != null && !fileHtml.toString().contains('not allowed') && fileHtml.toString().length > 2) {
            moduleProjectClass.filesUrls = new List<String>();
            for (var elem in fileHtml) {
                moduleProjectClass.filesUrls.add(elem["fullpath"]);
            }
        } else {
            moduleProjectClass.filesUrls = null;
        }

        return moduleProjectClass;
    }

    Future<ModuleBoard> parseModuleBoard(DateTime begin, DateTime end) async {
        String url = autolog + "/module/board/?format=json&start=";
        dynamic formatter = DateFormat('yyyy-MM-dd');

        url += formatter.format(begin);
        url += "&end=" + formatter.format(end);
        dynamic moduleBoard = await this._network.get(url);
        if (moduleBoard == null)
            return null;

        Map<String, dynamic> json = {
            "modules": moduleBoard
        };
        ModuleBoard moduleBoardClass = ModuleBoard.fromJson(json);
        moduleBoardClass.registeredProjects = new List<BoardModule>();

        moduleBoardClass.projectsToDeliveryAmount = 0;
        for (BoardModule module in moduleBoardClass.modules) {
            if (module.registered != 1 || module.type != "proj")
                continue;
            moduleBoardClass.projectsToDeliveryAmount++;
            moduleBoardClass.registeredProjects.add(module);
        }

        return moduleBoardClass;
    }

    Future<ScheduleDay> parseScheduleDay(DateTime day) async {
        String url = autolog + "/planning/load?format=json&start=";
        dynamic formatter = DateFormat('yyyy-MM-dd');

        url += formatter.format(day);
        url += ("&end=" + formatter.format(day));

        dynamic json = await this._network.get(url);
        return ScheduleDay.fromJson({"sessions": json});
    }

    Future<ModuleInformation> parseModuleInformation(String slug) async {
        String url = autolog + slug + "?format=json";
        dynamic json = await this._network.get(url);

        return ModuleInformation.fromJson(json);
    }

    Future<RegistrationSlots> parseSessionRegistrationSlots(String slug) async {
        String url = autolog + slug + "?format=json";
        dynamic json = await this._network.get(url);

        return RegistrationSlots.fromJson(json);
    }

    Future<Results> parseEpitest(String year, String bearer) async {
        String url = "https://api.epitest.eu/me/" + year;
        print(url);
        print(bearer);
        dynamic json = await this._network.get(url, bearer: bearer);
        Map<String, dynamic> jsonToParse = {
            "results": json
        };

        Results results = Results.fromJson(jsonToParse);
        double skillsAmount = 0;
        double skillTotal = 0;

        for (var res in results.results) {
            for (var skill in res.results.skills.values) {
		skillTotal += skill.count;
                skillsAmount += skill.passed;
	    }
            res.results.percentage = (skillsAmount / skillTotal) * 100;
            skillTotal = 0;
            skillsAmount = 0;
	}

        return results;
    }

}