class Validator {
  static String checkEmptyField(dynamic value) {
    if (value == null || value.isEmpty) {
      return "Please input this field";
    }
    return "";
  }

  static String checkPasswordCorrect(dynamic value) {
    var emptyResult = checkEmptyField(value);
    if (emptyResult.isEmpty) {
      if (value.length < 8) {
        return 'Your password must be at least 8 symbols.';
      }
      return "";
    }
    return emptyResult;
  }

  static String checkEmail(dynamic value) {
    var emptyResult = checkEmptyField(value);
    if (emptyResult.isNotEmpty) {
      return emptyResult;
    }
    var pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    var regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Not a valid email address. Should be your@email.com';
    }
    return "";
  }

  static String checkSecondInputPassword(
      String passsword, String secondPassword) {
    var emptyResult = checkEmptyField(secondPassword);
    if (emptyResult.isNotEmpty) {
      return emptyResult;
    }
    if (passsword != secondPassword) {
      return "Your password does not match. Please input again";
    }
    return "";
  }
}
