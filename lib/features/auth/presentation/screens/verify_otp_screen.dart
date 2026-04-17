import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/center_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../../app/providers/timer_provider.dart';
import '../widgets/resend_otp_section.dart';
import '../widgets/app_logo.dart';
import '../widgets/snack_bar_message.dart';

class VerifyOTPScreen extends StatefulWidget {

  const VerifyOTPScreen({super.key, required this.email});

  static const String routeName = '/verify-otp-screen';

  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {

  late PinInputController _pinInputController;
  late TimerProvider _timerProvider;

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  // void onTapSignUp() {
  //   Navigator.pop(context);
  // }


  @override
  void initState() {
    super.initState();
    _pinInputController = PinInputController();
    // Calling a method of timer provider
    _timerProvider = context.read<TimerProvider>();
    _timerProvider.startTimer();
  }

  @override
  void dispose() {
    _pinInputController.dispose();
    _timerProvider.stopTimer(); // Using context in dispose unsafe cause it might not exist when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: _verifyOtpProvider,
      child: Scaffold(

        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 160),
                    Center(
                      child: AppLogo(
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(context.l10n.verifyOTP, style: context.textTheme.titleLarge),
                    Text(context.l10n.verifyOTPDescription, style: context.textTheme.bodyLarge),
                    const SizedBox(height: 25),
                    MaterialPinField(
                        pinController: _pinInputController,
                        length: 4,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        theme: MaterialPinTheme(
                          shape: MaterialPinShape.outlined,
                          fillColor: Colors.transparent,
                          borderColor: AppColors.themeColor,
                          spacing: 16,
                          cellSize: Size(50, 50),
                          completeBorderColor: Colors.transparent ,
                          completeFillColor: AppColors.themeColor,
                        ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<VerifyOtpProvider>(
                      builder: (context, provider, child) {

                        if(provider.verifyOTPInProgress) return const CenterProgressIndicator();

                        return FilledButton(
                          onPressed: onTapVerify,
                          child: Text(context.l10n.verifyOTPButton),
                        );
                      }
                    ),
                    const SizedBox(height: 22),
                    ResendOTPSection(email: widget.email),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapVerify() {

    if (_pinInputController.text.length == 4){

      _verifyOTP();

    } else {
      showSnackBarMessage(context: context, message: 'OTP is not Valid', color: Colors.redAccent);
    }
  }

  Future<void> _verifyOTP() async {

    VerifyOtpParams params = VerifyOtpParams(
        email: widget.email,
        otp: _pinInputController.text
    );

    final bool isSuccess = await _verifyOtpProvider.signUp(params);

    if (isSuccess){
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, MainNavHolderScreen.routeName, (predicate) => false);
    } else {
      if(!mounted) return;
      showSnackBarMessage(context: context, message: _verifyOtpProvider.errorMessage ?? 'Something Went wrong in Verify OTP Screen', color: Colors.redAccent);
    }


  }

}


