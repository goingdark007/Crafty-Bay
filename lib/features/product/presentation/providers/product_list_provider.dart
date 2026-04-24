import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';

class ProductListProvider extends ChangeNotifier{

  // The number of items in one page
  final int _pageSize = 30;

  // Pagination state
  int _currentPage = 0;
  int? _lastPage;

  // Loading states
  bool _initialDataInProgress = false;
  bool _moreDataInProgress = false;
  String? _errorMessage;

  // Data
  final List<ProductModel> _productList = [];

  // Getters
  bool get initialDataInProgress => _initialDataInProgress;
  bool get moreDataInProgress => _moreDataInProgress;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;

  //bool get isInitialLoading => _currentPage == 0;
  bool get isLoading => _initialDataInProgress || _moreDataInProgress;

  // hasMore: tells UI whether to show "load more" trigger
  bool get hasMore  {
    if(_lastPage == null) return true;
    if(_currentPage < _lastPage!) return true;
    return false;
  }

  // More data loading

  Future<bool> getProducts(String categoryId) async {

    bool isSuccessful = false;

    if(isLoading || !hasMore) {
      return false;
    }

    // 🔥 HARD STOP (this is the real fix)
    // if (_lastPage != null && _currentPage >= _lastPage!) {
    //   return false;
    // }


    if (_currentPage == 0) {
      _initialDataInProgress = true;
    } else {
      _moreDataInProgress = true;
    }

    _currentPage++;

    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(Urls.getProductsUrl(pageSize: _pageSize, page: _currentPage, categoryId: categoryId));

    if(response.isSuccess){

      isSuccessful = true;
      _errorMessage = null;

      final responseData = response.body!['data'];

      // Assign _lastPage form API, without this, pagination never stops
      _lastPage ??= responseData["last_page"];
      debugPrint('$_lastPage');

      final List<dynamic> data = responseData['results'];

      _productList.addAll(data.map(
              (e) => ProductModel.fromJson(e)
      ).toList());

    } else {

      isSuccessful = false;
      _errorMessage = response.errorMessage ?? 'Something Went Wrong';

      // Rollback page on failure so user can retry the same page
      _currentPage--;

    }

    // reset loading
    if(_initialDataInProgress) _initialDataInProgress = false;
    if(_moreDataInProgress) _moreDataInProgress = false;
    notifyListeners();

    return isSuccessful;

  }

  // Must have: pull to refresh support
  Future<bool> refreshProducts(String categoryId) async {

    _currentPage = 0;
    _lastPage = null;
    _productList.clear();
    _errorMessage = null;

    // recursion and no notifyListeners here getCategories will do it
    return getProducts(categoryId);

  }

}