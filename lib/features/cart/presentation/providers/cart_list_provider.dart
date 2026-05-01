import 'package:flutter/material.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../data/models/cart_item_model.dart';

class CartListProvider extends ChangeNotifier {

  bool _inProgress = false;
  List<CartItemModel> _cartItems = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<CartItemModel> get cartItems => _cartItems;
  String? get errorMessage => _errorMessage;

  int get totalQuantity => _cartItems.length;

  double get totalPrice {
    double total = 0;
    List.generate(cartItems.length, (index) {
      total += cartItems[index].productModel.currentPrice * cartItems[index].quantity;
    });
    return total;
  }

  double productPriceByCartId(String cartId) {
    double price = 0;
    final cartItemModel = cartItems.firstWhere((e) => e.id == cartId);
    price = (cartItemModel.productModel.currentPrice * cartItemModel.quantity).toDouble();
    return price;
  }

  void updateCartItemQuantity(String cartId, int quantity){

    cartItems.firstWhere((e) => e.id == cartId)
        .quantity = quantity; // .quantity means we are updating the quantity of the cart item with the given cartId
    notifyListeners();
  }

  Future<bool> getCartList() async {

    bool isSuccess = false;

    _inProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(Urls.cartUrl);

    if (response.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

      final List<dynamic> data = response.body!['data']['results'];

      _cartItems = data.map(
              (e) => CartItemModel.fromJson(e)
      ).toList();

    } else {

      isSuccess = false;
      _errorMessage = response.errorMessage ?? 'Failed to load cart items';

    }

    _inProgress = false;
    notifyListeners();

    return isSuccess;

  }


  Future<bool> deleteCartItem(String cartId) async {

    bool isSuccess = false;

    // _inProgress = true;
    // notifyListeners();

    final NetworkResponse response = await getNetworkCaller().deleteRequest(Urls.deleteCartItemUrl(cartId), null);

    if (response.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

      _cartItems.removeWhere((e) => e.id == cartId);

    } else {

      isSuccess = false;
      _errorMessage = response.errorMessage ?? 'Failed to delete cart item';

    }

    notifyListeners();

    return isSuccess;

  }

}
