import 'package:flutter/cupertino.dart';

import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../data/models/sign_up_model.dart';

class SignUpProvider extends ChangeNotifier{

  bool _signUpInProgress = false;
  String? _errorMessage;

  bool get signUpInProgress => _signUpInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpModel model) async {

    bool isSuccessful = false;

    _signUpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(Urls.signUpUrl, model.toJson());

    if(response.isSuccess){

      _errorMessage = null;
      isSuccessful = true;

    } else {
      _errorMessage = response.errorMessage;
    }

    _signUpInProgress = false;
    notifyListeners();

    return isSuccessful;


  }


}