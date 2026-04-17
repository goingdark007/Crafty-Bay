import 'package:crafty_bay/features/home/data/models/home_slider_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';

class HomeSliderProvider  extends ChangeNotifier{

  bool _homeSliderInProgress = false;
  List<HomeSliderModel> _homeSliders = [];
  String? errorMessage;

  bool get getHomeSliderInProgress => _homeSliderInProgress;
  List<HomeSliderModel> get homeSliders => _homeSliders;
  String? get getErrorMessage => errorMessage;

  Future<bool> getHomeSlider() async {

    bool isSuccess = false;

    _homeSliderInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(Urls.slidesUrl);

    if(response.isSuccess){

      isSuccess = true;
      errorMessage = null;

      final List<dynamic> data = response.body!['data']['results'];

      _homeSliders = data.map(
              (e) => HomeSliderModel.fromJson(e)
      ).toList();

    } else {

      isSuccess = false;
      errorMessage = response.errorMessage;

    }

    _homeSliderInProgress = false;
    notifyListeners();

    return isSuccess;

  }


}