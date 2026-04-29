import 'package:flutter/material.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../data/models/add_to_cart_params.dart';

class AddToCartProvider extends ChangeNotifier {

  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(AddToCartParams params) async {

    bool isSuccess = false;

    _inProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
        url: Urls.addToCartUrl,
        body: params.toJson()
    );

    if (response.isSuccess) {

      isSuccess = true;
      _errorMessage = null;

    } else {

      isSuccess = false;
      _errorMessage = response.errorMessage ?? 'Failed to add product to cart';

    }

    _inProgress = false;
    notifyListeners();

    return isSuccess;

  }

}
