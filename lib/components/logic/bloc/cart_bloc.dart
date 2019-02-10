import 'dart:async';

import 'package:mobile_intranet/components/logic/viewmodel/cart_view_model.dart';
import 'package:mobile_intranet/components/model/product.dart';

class CartBloc {
  CartViewModel _cartViewModel;
  final additionalController = StreamController<bool>();
  final subtractionController = StreamController<bool>();
  final countController = StreamController<int>();
  Sink<bool> get addItem => additionalController.sink;
  Sink<bool> get subtractItem => subtractionController.sink;
  Stream<int> get getCount => countController.stream;

  CartBloc(Product p) {
    _cartViewModel = CartViewModel(product: p);
    additionalController.stream.listen(onAdd);
    subtractionController.stream.listen(onDelete);
  }

  void onAdd(bool done) {
    _cartViewModel.addQuantity();
    countController.add(_cartViewModel.totalQuantity);
  }

  void onDelete(bool done) {
    _cartViewModel.deleteQuantity();
    countController.add(_cartViewModel.totalQuantity);
  }

  void dispose() {
    additionalController?.close();
    subtractionController?.close();
    countController?.close();
  }
}
