class TextValidator {
  static String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email введен некорректно'; // Email is entered incorrectly
    } else {
      return null;
    }
  }

  static String passwordValidator(String value) {
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов'; // Password must be at least 6 characters
    } else {
      return null;
    }
  }

  static String isEmptyValidator(String value, String title) {
    if (value.isEmpty) {
      return 'Введите $title'; // Enter $title
    } else {
      return null;
    }
  }
}
