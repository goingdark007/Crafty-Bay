class VerifyOtpParams {

  final String email;
  final String otp;

  const VerifyOtpParams({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }

}