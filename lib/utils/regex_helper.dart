String symbol = "-";

class AppRegex {
  // Name
  static RegExp nameRegex = RegExp(r"^[a-zA-Z ]+$");

  // cnicNumber
  // static int cnicLength = symbol == "" ? 13 : 15;
  static int cnicLength = 13;
  static RegExp cnicRegex = RegExp("^[0-9]{5}[0-9]{7}[0-9]{1}");
  static cNICchangeOnFormate(String cnic) {
    String a =
        "${cnic.substring(0, 5)}$symbol${cnic.substring(5, 12)}$symbol${cnic.substring(12, cnic.length)}";
    return a;
  }

  // phoneNumber
  // static int phoneNumberLength = symbol == "" ? 12 : 13;
  static int phoneNumberLength = 12;
  static RegExp phoneNumberRegex = RegExp("r^[0-9]{4} [0-9]{7}");

  static phoneNumberChangeOnFormate(String phoneNumber) {
    String a =
        "${phoneNumber.substring(0, 4)}$symbol${phoneNumber.substring(4, phoneNumber.length)}";
    return a;
  }

  // passbook
  // static int passbookNumberLength = symbol == "" ? 12 : 15;
  static int passbookNumberLength = 12;
  static RegExp passbookNumberRegex =
      RegExp("r^[0-9]{2}[0-9]{2}[0-9]{3}[0-9]{5}");
  // RegExp("^[0-9]{2} [0-9]{2} [0-9]{3} [0-9]{5}");

  static passbookNumberChangeOnFormate(String passbookNumber) {
    String a =
        "${passbookNumber.substring(0, 2)}$symbol${passbookNumber.substring(2, 4)}$symbol${passbookNumber.substring(4, 7)}$symbol${passbookNumber.substring(7, passbookNumber.length)}";
    return a;
  }

  static String removeSymbol(String text) {
    return text
        .replaceAll(symbol, "")
        .replaceAll(" ", "")
        .replaceAll("-", "")
        .replaceAll(",", "");
  }
}
