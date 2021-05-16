/// Localization Keys used in bdaya_utils package
enum BdayaUtilsLocalizationKeys {
  /// When the input is null (or empty), and the field is required
  VALIDATION_REQUIRED_INPUT,

  /// When the input email doesn't match the regex
  ///
  /// params:
  /// * val = the input value
  VALIDATION_EMAIL_INCORRECT,

  /// When the input string doesn't uphold the min length restriction
  ///
  /// params:
  /// * len = the minimum number of letters
  /// * val = the input value
  /// * valLen = the input value length
  VALIDATION_MIN_LENGTH,

  /// When the input string doesn't uphold the max length restriction
  ///
  /// params:
  /// * len = the maximum number of letters </p>
  /// * val = the input value
  /// * valLen = the input value length
  VALIDATION_MAX_LENGTH,
}

class BdayaUtilsLocalizationHandler {
  /// call this
  static void init({
    String? Function(
      BdayaUtilsLocalizationKeys key,
      Map<String, String>? params,
    )?
        resolver,
    RegExp? emailRegExp,
  }) {
    if (resolver != null) {
      _resolver = resolver;
    }
    if (emailRegExp != null) {
      emailValidatorRegExp = emailRegExp;
    }
  }

  /// the email regex used to compare email inputs
  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

  /// Default resolver in case none is provided (language arabic)
  static String? Function(
    BdayaUtilsLocalizationKeys key,
    Map<String, String>? params,
  ) _resolver = (key, params) {
    switch (key) {
      case BdayaUtilsLocalizationKeys.VALIDATION_REQUIRED_INPUT:
        return 'هذا الحقل مطلوب';
      case BdayaUtilsLocalizationKeys.VALIDATION_EMAIL_INCORRECT:
        return 'البريد الالكتروني غير صحيح';
      case BdayaUtilsLocalizationKeys.VALIDATION_MIN_LENGTH:
        return 'عدد الحروف يجب ألا يقل عن ${params!["len"]}';
      case BdayaUtilsLocalizationKeys.VALIDATION_MAX_LENGTH:
        return 'عدد الحروف يجب ألا يزيد عن ${params!["len"]}';
      default:
        return null;
    }
  };
  static String? current(
    BdayaUtilsLocalizationKeys key, {
    Map<String, String>? params,
  }) {
    return _resolver(key, params);
  }
}
