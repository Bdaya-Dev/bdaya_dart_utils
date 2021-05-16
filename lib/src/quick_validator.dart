import 'package:bdaya_utils/src/localization_handler.dart';

class QuickGenericValidator<T> {
  final bool isRequired;
  final String? Function(T? value)? extraValidation;

  const QuickGenericValidator({
    this.isRequired = true,
    this.extraValidation,
  });
  String? call(T? value) => validate(value);

  String? validate(T? value) {
    if (isRequired == true) {
      if (value == null) {
        return BdayaUtilsLocalizationHandler.current(
          BdayaUtilsLocalizationKeys.VALIDATION_REQUIRED_INPUT,
        );
      }
    }
    final res = extraValidation?.call(value);
    return res;
  }
}

class QuickTextValidator extends QuickGenericValidator<String> {
  final bool? isEmail;
  final bool? isNumber;
  final int? hasMinLength;
  final int? hasMaxLength;

  QuickTextValidator({
    bool isRequired = true,
    String? Function(String? value)? extraValidation,
    this.isEmail,
    this.isNumber,
    this.hasMinLength,
    this.hasMaxLength,
  }) : super(
          isRequired: isRequired,
          extraValidation: (value) {
            if (isRequired && value!.isEmpty) {
              return BdayaUtilsLocalizationHandler.current(
                BdayaUtilsLocalizationKeys.VALIDATION_REQUIRED_INPUT,
              );
            }
            if (value != null && value.isNotEmpty) {
              if (isEmail == true) {
                if (!BdayaUtilsLocalizationHandler.emailValidatorRegExp
                    .hasMatch(value)) {
                  return BdayaUtilsLocalizationHandler.current(
                    BdayaUtilsLocalizationKeys.VALIDATION_EMAIL_INCORRECT,
                    params: {
                      'val': value,
                    },
                  );
                }
              }
              if (hasMinLength != null) {
                if (value.length < hasMinLength) {
                  return BdayaUtilsLocalizationHandler.current(
                    BdayaUtilsLocalizationKeys.VALIDATION_MIN_LENGTH,
                    params: {
                      'val': value,
                      'len': hasMinLength.toString(),
                      'valLen': value.length.toString(),
                    },
                  );
                }
              }
              if (hasMaxLength != null) {
                if (value.length < hasMaxLength) {
                  return BdayaUtilsLocalizationHandler.current(
                    BdayaUtilsLocalizationKeys.VALIDATION_MAX_LENGTH,
                    params: {
                      'val': value,
                      'len': hasMaxLength.toString(),
                      'valLen': value.length.toString(),
                    },
                  );
                }
              }

              final res = extraValidation?.call(value);
              return res;
            }
            return null;
          },
        );
}
