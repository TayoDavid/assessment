class Validator {
  static String? validInput(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field is required';
    }
    return null;
  }
}
