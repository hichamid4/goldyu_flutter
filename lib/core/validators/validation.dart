class TValidation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Email regex pattern
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // check for minimum password length
    if (value.length < 6) {
      return 'Password must contain at least 8 characters.';
    }

    // check for uppercsae letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least 1 uppercase letter (ABC).';
    }

    // check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least 1 number (123).';
    }

    // check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least 1 special character (!@#).';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Phone number regex pattern for Morocco
    if (!RegExp(r'^(?:\+212|0)[6-7]\d{8}$').hasMatch(value)) {
      return 'Please enter a valid Moroccan phone number.';
    }
    return null;
  }
}
