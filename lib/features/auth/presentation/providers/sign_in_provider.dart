import 'package:flutter/material.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../../shared/data/models/user_model.dart';
import '../../data/models/sign_in_params.dart';

class SignInProvider extends ChangeNotifier{

  bool _signInProgress = false;
  String? _errorMessage;

  bool get signInProgress => _signInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params) async {

    bool isSuccessful = false;

    _signInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(Urls.signInUrl, params.toJson());

    if(response.isSuccess){

      final responseData = response.body!['data'];

      // TODO: Save user data
      UserModel userModel = UserModel.fromJson(responseData['user']);
      AuthController.saveUserData(responseData['token'], userModel);
      _errorMessage = null;
      isSuccessful = true;

    } else {
      _errorMessage = response.errorMessage;
    }

    _signInProgress = false;
    notifyListeners();

    return isSuccessful;

  }

}