class Validators {
  static bool hasMinLength(String value, {int min = 8}) {
    return value.length >= min;
  }

  static bool hasUpperCase(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  static bool hasLowerCase(String value) {
    return RegExp(r'[a-z]').hasMatch(value);
  }

  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z]\w*([_.-]\w*)?@[a-zA-Z\d]+([.-][a-zA-Z\d]+)*\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  static bool isNotValidEmail(String email) => !isValidEmail(email);

  static String? validateLoginCredentials({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill in all fields.';
    }

    if (isNotValidEmail(email)) {
      return 'Please enter a valid email.';
    }

    return null;
  }

  static String? validateForgotPasswordEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email address.';
    }

    if (isNotValidEmail(email)) {
      return 'Please enter a valid email.';
    }

    return null;
  }

  static String? validateOtpCode(String otpCode) {
    if (otpCode.isEmpty) {
      return 'Please enter the 6-digit code.';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(otpCode)) {
      return 'Please enter a valid 6-digit code.';
    }

    return null;
  }

  static String? validateProfileChangePasswordCredentials({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      return 'Please fill in all fields.';
    }

    if (newPassword != confirmPassword) {
      return 'New password and confirm password must match.';
    }

    if (!hasMinLength(newPassword) ||
        !hasUpperCase(newPassword) ||
        !hasLowerCase(newPassword)) {
      return 'Password must include 8+ characters, 1 upper-case, and 1 lower-case.';
    }

    return null;
  }

  static String? validateNewPasswordCredentials({
    required String newPassword,
    required String confirmPassword,
  }) {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      return 'Please fill in all fields.';
    }

    if (newPassword != confirmPassword) {
      return 'Passwords do not match.';
    }

    return null;
  }

  static String? validateProfileUpdateData({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty) {
      return 'Please fill in all fields.';
    }

    if (isNotValidEmail(email)) {
      return 'Please enter a valid email.';
    }

    return null;
  }

  static bool isValidPassword(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9].*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  static bool isNotValidPassword(String password) => !isValidPassword(password);

  // static bool isNotValidPhone(String phone) {
  //   // if (phone.length < 8 || phone.length > 12) {
  //   //   return true;
  //   // }

  //   return RegExp("(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9].*[0-9])(?=.*[^a-zA-Z0-9]).{8,}")
  //       .hasMatch(phone);
  // }

  static bool isPhoneNumberValid(String phoneNumber, String countryCode) {
    switch (countryCode) {
      case '+966' || '966': // Saudi (Done)
        return RegExp(
          r'^(50|53|54|55|56|57|58|59)[0-9]{7}$',
        ).hasMatch(phoneNumber);
      case '+971' || '971': // Emirates (Done)
        return RegExp(
          r'^((?:[1-9]|0(?=[1-9]))[0-9]{8})$',
        ).hasMatch(phoneNumber);
      case '+965' || '965': // Kuwait (Done)
        return RegExp(r'^(5|6|9)[0-9]{7}$').hasMatch(phoneNumber);
      case '+974' || '974': // Qatar (Done)
        return RegExp(
          r'^(33|44|55|66|77|88|99)[0-9]{6}$',
        ).hasMatch(phoneNumber);
      case '+973' || '973': // Bahrain (Done)
        return RegExp(r'^(3|4|6|8|9)[0-9]{7}$').hasMatch(phoneNumber);
      case '+962' || '962': // Jordan
        // 789434343
        // 795454545
        return RegExp(r'^(7[789]\d{7})$').hasMatch(phoneNumber);
      case '+20' || '20': // Egypt
        return RegExp(r'^(10|11|12|15)[0-9]{8}$').hasMatch(phoneNumber);
      default:
        return false;
    }
  }

  static List<String> getPasswordValidationErrors(String password) {
    List<String> errors = [];

    if (password.length < 8) {
      errors.add(PasswordConditions.minLength);
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add(PasswordConditions.upperCase);
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add(PasswordConditions.lowerCase);
    }

    if (!RegExp(r'[0-9!@#\$&*~]').hasMatch(password)) {
      errors.add(PasswordConditions.numberOrSymbol);
    }

    return errors;
  }
}

class PasswordConditions {
  static const String minLength =
      'Password must be at least 8 characters long.';
  static const String upperCase =
      'Password must contain at least one uppercase letter.';
  static const String lowerCase =
      'Password must contain at least one lowercase letter.';
  static const String numberOrSymbol =
      'Password must contain at least two numbers or symbols.';
}
