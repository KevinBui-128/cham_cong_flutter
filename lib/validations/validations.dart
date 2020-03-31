class Validations{
  static bool isValidText(String text) {
    return text != null && text.length > 0;
  }

  static bool isValidUser(String user) {
    return user != null && user.length > 0;
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length >= 4 && pass.length <= 50;
  }


}