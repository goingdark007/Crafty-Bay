import 'package:flutter/material.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/setup_network_client.dart';
import '../../../../app/urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../../shared/data/models/user_model.dart';
import '../../data/models/verify_otp_params.dart';

class VerifyOtpProvider extends ChangeNotifier{

  bool _verifyOTPInProgress = false;
  String? _errorMessage;

  bool get verifyOTPInProgress => _verifyOTPInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(VerifyOtpParams params) async {

    bool isSuccessful = false;

    _verifyOTPInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(Urls.verifyOTP, params.toJson());

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

    _verifyOTPInProgress = false;
    notifyListeners();

    return isSuccessful;

  }

  Future<bool> resendOtp(String email) async {

    bool isSuccessful = false;

    final userEmailData = {
      'email' : email
    };

    final NetworkResponse response = await getNetworkCaller().postRequest(Urls.resendOTP, userEmailData);

    if(response.isSuccess){
      _errorMessage = null;
      isSuccessful = true;

    } else {
      _errorMessage = response.errorMessage;
    }

    notifyListeners();

    return isSuccessful;

  }


}