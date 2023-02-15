
class Sanitizer {
  static String sanitizeText(dynamic value) {
    return (value == "null" || value == "" || value == "-" || value == "0" || value == null) ? "" : "$value";
  }

  static int sanitizeToInt(dynamic value) {
    // print(value.toString());
    if (value is int) return value;
    return (value == "null" || value == "" || value == "-" || value == "0" || value == null) ? 0 : int.parse('$value');
  }

  static double sanitizeToDouble(dynamic value) {
    return (value == "null" || value == "" || value == "-" || value == "0.0" || value == null) ? 0.0 : double.parse('$value');
  }

  static bool sanitizeToBoolean(dynamic value) {
    return (value == "0" || value == "" || value == 0 || value == null) ? false : true;
  }

  static String sanitizeImage(dynamic value) {
    return (value == "null" || value == "" || value == null) ? "https://via.placeholder.com/150" : "$value";
  }
}