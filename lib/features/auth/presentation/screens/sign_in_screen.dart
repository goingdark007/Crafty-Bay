import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../../app/validation.dart';
import '../../../shared/presentation/screens/main_nav_holder_screen.dart';
import '../../data/models/sign_in_params.dart';
import '../providers/sign_in_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/center_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool isPasswordVisible = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInProvider _signInProvider = SignInProvider();

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void onTapSignUp() {
    Navigator.pop(context);
  }

  void onTapSignIn() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn () async {

    final SignInParams params = SignInParams(
        email: _emailController.text,
        password: _passwordController.text
    );

    final bool isSuccess = await _signInProvider.signIn(params);

    if(isSuccess){
      if(!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, MainNavHolderScreen.routeName, (predicate) => false);
      showSnackBarMessage(context: context, message: 'Sign In Successful', color: Colors.green);
    } else {
      if(!mounted) return;
      showSnackBarMessage(context: context, message: _signInProvider.errorMessage ?? 'Something Went wrong in Sign In Screen', color: Colors.redAccent);
    }

  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: _signInProvider,
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
                    mainAxisSize: .min,
                    children: [
                      const SizedBox(height: 150),
                      Center(
                        child: AppLogo(
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(context.l10n.signInLogin, style: context.textTheme.titleLarge),
                      Text(context.l10n.signInGetStarted, style: context.textTheme.bodyLarge),
                      const SizedBox(height: 25),
                      TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hint: Text(context.l10n.email)
                          ),
                         validator: Validation.emailValidator,
                      ),
                      const SizedBox(height: 20),
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
                      Consumer<SignInProvider>(
                        builder: (BuildContext context, provider, child) {

                          if (provider.signInProgress) return const CenterProgressIndicator();

                          return FilledButton(
                            onPressed: onTapSignIn,
                            child: Text(context.l10n.signIn),
                          );
                        }
                      ),
                      TextButton(
                        onPressed: onTapSignUp,
                        child: Text(context.l10n.signInSignUp, style: context.textTheme.bodyMedium),
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
