import 'dart:async';

import 'package:mobile_intranet/components/logic/viewmodel/menu_view_model.dart';
import 'package:mobile_intranet/components/model/menu.dart';

class MenuBloc {
  final _menuVM = MenuViewModel();
  final menuController = StreamController<List<Menu>>();

  Stream<List<Menu>> get menuItems => menuController.stream;

  MenuBloc() {
    menuController.add(_menuVM.getMenuItems());
  }
}
