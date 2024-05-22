import 'package:two_way_dael/core/helpers/app_regex.dart';

String? passwordValidation(value) {
  if (value == null || value.isEmpty) {
    return 'Please Enter Your Password';
  } else if (!AppRegex.hasUpperCase(value)) {
    return 'Password Must Include Uppercase letters (A-Z)';
  } else if (!AppRegex.hasLowerCase(value)) {
    return 'Password Must Include Lowercase letters (a-z)';
  } else if (!AppRegex.hasNumber(value)) {
    return 'Password Must Include Numbers (0-9)';
  } else if (!AppRegex.hasSpecialCharacter(value)) {
    return 'Password Must Include Special characters (!@#\$%^&*)';
  } else if (!AppRegex.hasMinLength(value)) {
    return 'password must be at least 8 characters long';
  } else {
    return null;
  }
}

String? emailValidation(value) {
  if (value == null || value.isEmpty) {
    return 'Please Enter Your Email Address.';
  } else if (!AppRegex.isEmailValid(value)) {
    return 'Please Enter a Valid Email Address Format \njohn.doe@gmail.com.';
  } else {
    return null;
  }
}
