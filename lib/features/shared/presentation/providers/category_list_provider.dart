import 'package:flutter/material.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../data/models/category_model.dart';

class CategoryListProvider extends ChangeNotifier{


  final int _pageCount = 30;
  int _currentPage = 0;
  int? _lastPage;

  // Initial Loading
  bool _initialDataInProgress = false;
  bool _moreDataInProgress = false;
  String? _errorMessage;

  List<CategoryModel> _categoryList = [];

  bool get initialDataInProgress => _initialDataInProgress;
  bool get moreDataInProgress => _moreDataInProgress;
  List<CategoryModel> get categoryList => _categoryList;
  String? get errorMessage => _errorMessage;

  bool get isInitialLoading => _currentPage == 0;
  bool get isLoading => initialDataInProgress || moreDataInProgress;
  bool get isMoreLoading => _currentPage > 0;

  // More data loading

  Future<bool> getCategories() async {

    bool isSuccessful = false;

    if(_lastPage != null && _currentPage >= _lastPage!) {
      return false;
    }

    _currentPage++;

    if (isInitialLoading) {
      _initialDataInProgress = true;
    } else {
      _moreDataInProgress = true;
    }

    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(Urls.getCategoriesUrl(_pageCount, _currentPage));

    if(response.isSuccess){

      isSuccessful = true;
      _errorMessage = null;

      final List<dynamic> data = response.body!['data']['results'];

      _categoryList.addAll(data.map(
              (e) => CategoryModel.fromJson(e)
      ).toList());

    } else {

      isSuccessful = false;
      _errorMessage = response.errorMessage ?? 'Something Went Wrong';

    }

    return isSuccessful;

  }

}