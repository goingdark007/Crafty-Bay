import 'package:email_validator/email_validator.dart';

class Validation {

  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');


  static String? emailValidator (String? value){
    if (value == null || value.isEmpty) return 'Please Enter Your Email';
    // We can use Regex or Email Validator package for email validation. Here we used both
    if (!_emailRegex.hasMatch(value) || !EmailValidator.validate(value)) return 'Please Enter Valid Email';
    return null;
  }

  static String? nameValidator (String? value, String name) {

    if (value == null || value.isEmpty) return 'Please Enter Your $name Name';
    if (value.length < 3) return '$name Name must be at least 3 characters long';
    return null;

  }

  static String? mobileValidator (String? value) {
    if (value == null || value.isEmpty) return 'Please Enter Your Mobile Number';
    if (value.length < 3) return 'Mobile Number must be 11 digits long';
    return null;
  }

  static String? cityValidator (String? value) {
    if (value == null || value.isEmpty) return 'Please Enter Your City';
    return null;
  }

  static String? passwordValidator (String? value) {
    if (value == null || value.isEmpty) return 'Please Enter Your Password';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    return null;
  }

}