import 'package:flutter/material.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../data/models/product_details_model.dart';

class ProductDetailsProvider extends ChangeNotifier {

  bool _productDetailsInProgress = false;
  ProductDetailsModel? _productDetails;
  String? _errorMessage;
  String? _productId;

  bool get getProductDetailsInProgress => _productDetailsInProgress;
  ProductDetailsModel? get productDetails => _productDetails;
  String? get getErrorMessage => _errorMessage;
  String? get productId => _productId;

  Future<bool> getProductDetails(String productId) async {

    bool isSuccess = false;
    _productId = productId;

    _productDetailsInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(Urls.getProductDetails(productId: productId));

    if(response.isSuccess){

      isSuccess = true;
      _errorMessage = null;

      _productDetails = ProductDetailsModel.fromJson(response.body!['data']);

    } else {

      isSuccess = false;
      _errorMessage = response.errorMessage;

    }

    _productDetailsInProgress = false;
    notifyListeners();

    return isSuccess;

  }

}