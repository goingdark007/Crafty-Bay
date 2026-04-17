import 'package:crafty_bay/core/network_caller/network_caller.dart';

// Best practice => Service locator (Get it package) / Dependency injection

NetworkCaller getNetworkCaller () {

  return NetworkCaller(
      headers: () => {
        'Content-Type' : 'application/json'
      },
      onUnAuthorized: () {
        // Log out from app
        // clear user data
        // redirect to sign in ui
      }
  );

}

// Uses -> getNetworkCaller().getRequest()