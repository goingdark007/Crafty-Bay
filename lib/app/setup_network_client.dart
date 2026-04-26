import '../core/network_caller/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'controllers/auth_controller.dart';
import 'crafty_bay_app.dart';

// Best practice => Service locator (Get it package) / Dependency injection

NetworkCaller getNetworkCaller () {

  return NetworkCaller(
      headers: () => {
        'Content-Type' : 'application/json'
      },
      onUnAuthorized: () async {
        // Log out from app
        // clear user data
        await AuthController.clearUserData();
        // redirect to sign in ui
        CraftyBay.navigatorKey.currentState?.pushNamed(SignInScreen.routeName);
      }
  );

}

// Uses -> getNetworkCaller().getRequest()