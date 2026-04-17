import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_model.dart';
import 'package:crafty_bay/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../../app/validation.dart';
import '../widgets/app_logo.dart';
import '../widgets/center_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  static const String routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isPasswordVisible = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _cityController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpProvider _signUpProvider = SignUpProvider();

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void onTapSignUp() {
    if (_formKey.currentState!.validate()){
      _signUp();
    }
  }

  Future<void> _signUp() async {

    SignUpModel model = SignUpModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _mobileController.text.trim(),
      city: _cityController.text.trim(),
      password: _passwordController.text
    );

    final bool isSuccess = await _signUpProvider.signUp(model);

    if (isSuccess){
      if (!mounted) return;
      Navigator.pushNamed(context, VerifyOTPScreen.routeName, arguments: _emailController.text.trim());
      showSnackBarMessage(context: context, message: 'Signed up Successfully', color: Colors.green);
    } else {
      if (!mounted) return;
      showSnackBarMessage(context: context, message: _signUpProvider.errorMessage!, color: Colors.redAccent);
    }

  }

  void onTapSignIn() {
    Navigator.pushNamed(context, SignInScreen.routeName, arguments: {'value' : 'value1'});
  }



  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _mobileController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(

        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: AppLogo(
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(context.l10n.signUpCreate, style: context.textTheme.titleLarge),
                    Text(context.l10n.signUpGetStarted, style: context.textTheme.bodyLarge),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hint: Text(context.l10n.email)
                      ),
                      validator: Validation.emailValidator
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _firstNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hint: Text(context.l10n.firstName)
                      ),
                      validator: (String? value) => Validation.nameValidator(value, 'First'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hint: Text(context.l10n.lastName)
                      ),
                      validator: (String? value) => Validation.nameValidator(value, 'Last'),
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _mobileController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hint: Text(context.l10n.mobile)
                      ),
                      validator: Validation.mobileValidator
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cityController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hint: Text(context.l10n.city)
                      ),
                      validator: Validation.cityValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !isPasswordVisible,
                      obscuringCharacter: '*',
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hint: Text(context.l10n.password),
                        suffixIcon: IconButton(
                          icon: isPasswordVisible ? const Icon(Icons.visibility, color: AppColors.themeColor,) : const Icon(Icons.visibility_off, color: AppColors.themeColor),
                          onPressed: _togglePasswordVisibility,
                        )
                      ),
                      validator: Validation.passwordValidator,
                    ),
                    const SizedBox(height: 16),
                    Consumer<SignUpProvider>(
                      builder: (context, provider, child) {

                        if(_signUpProvider.signUpInProgress){
                          return const CenterProgressIndicator();
                        }

                        return FilledButton(
                            onPressed: onTapSignUp,
                            child: Text(context.l10n.signUp),
                        );
                      }
                    ),
                    //const SizedBox(height: 1),
                    TextButton(
                      onPressed: onTapSignIn,
                      child: Text(context.l10n.signUpLogin, style: context.textTheme.bodyMedium),
                    )
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
