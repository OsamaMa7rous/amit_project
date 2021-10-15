import 'package:amit_project/cubit/states.dart';
import 'package:amit_project/model/products_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitClass extends Cubit<States> {
  CubitClass() : super(CounterInitialStates());

  static CubitClass get(context) => BlocProvider.of(context);

  static List<Product> cartList = [];
  void addProductToCart(Product product) {
    bool repetition = false;
    for (int i = 0; i < cartList.length; i++) {
      if (product.id == cartList[i].id) {
        repetition = true;
        cartList[i].count = cartList[i].count! + 1;
        break;
      }
    }
    if (repetition == false) {
      cartList.add(product);
    }
    emit(AddTOCartStates());
  }

  int CurrentIndex = 0;

  void minusProductCount() {
    emit(CounterMinusStates());
  }

  void plusProductCount() {
    emit(CounterPlusStates());
  }

  void clearCart() {
    cartList.clear();
    emit(ClearCartStates());
  }

  void deleteProductFromCart(var value) {
    cartList.remove(value);

    emit(DeleteProductStates());
  }

  void index(value) {
    CurrentIndex = value;
    emit(CurrentIndexStates());
  }
}
