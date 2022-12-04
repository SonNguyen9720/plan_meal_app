class StringUtils {
  static String parseString(String inputString) {
    String result = inputString.replaceAll('_', ' ');
    return result;
  }

  static String capitalizeFirstChar(String inputString) {
    if (inputString.isEmpty) {
      return '';
    }
    return "${inputString[0].toUpperCase()}${inputString.substring(1).toLowerCase()}";
  }
}