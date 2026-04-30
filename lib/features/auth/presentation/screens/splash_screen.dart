import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import '../../../shared/presentation/screens/main_nav_holder_screen.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget{

  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _moveToNextScreen() async {

    // await Future.delayed(const Duration(seconds: 4));
    // await AuthController.loadUserData();

    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      AuthController.loadUserData()
    ]);

    if(!mounted) return;
    Navigator.pushReplacementNamed(context, MainNavHolderScreen.routeName);

  }

  @override
  void initState(){
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(

            children: [

              Expanded(child: AppLogo()),

              const CircularProgressIndicator(),

              const SizedBox(height: 20)

            ]

          ),
        ),
      ),
    );

  }
}

