import 'package:crafty_bay/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../../app/providers/timer_provider.dart';

class ResendOTPSection extends StatelessWidget {
  const ResendOTPSection({
    super.key, required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {

    final TimerProvider timerProvider = context.watch<TimerProvider>();

    return Column(
      children: [
        if(!timerProvider.showResetOTPButton)
          RichText(
            text: TextSpan(
                text: context.l10n.verifyOTPTimer,
                style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                children: [
                  TextSpan(text: ' ${timerProvider.startTime}s', style: context.textTheme.bodyMedium)
                ]
            ),
          ),
        Visibility(
          visible: timerProvider.showResetOTPButton,
          child: TextButton(
            onPressed: () async {

              timerProvider.startTimer;

              final isSuccess = await context.read<VerifyOtpProvider>().resendOtp(email);

              if (!isSuccess && context.mounted) showSnackBarMessage(context: context, message: 'Failed to resend OTP', color: Colors.redAccent);

            },
            child: Text(context.l10n.verifyOTPResend, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

}