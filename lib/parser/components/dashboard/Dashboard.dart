import 'package:json_annotation/json_annotation.dart';
import 'DashboardBoard.dart';
import 'package:mobile_intranet/utils/network/NetworkUtils.dart';

class Dashboard {
    Board board;

    Dashboard(data) {
        this.board = Board.fromJson(data);
    }
}