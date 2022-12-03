class StringUtils {
  static String parseString(String inputString) {
    String result = inputString.replaceAll('_', ' ');
    return result;
  }
}