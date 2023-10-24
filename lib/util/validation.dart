abstract class StringValidation {
  const StringValidation();

  String? validate(String? value);
}

class ValidationComposite extends StringValidation {
  final List<StringValidation> _validations;

  const ValidationComposite({required List<StringValidation> validations})
      : _validations = validations;

  @override
  String? validate(String? value) {
    String? result;
    for (int i = 0; i < _validations.length; i++) {
      final validationResult = _validations[i].validate(value);
      if (validationResult == null) continue;
      if (validationResult.isNotEmpty) {
        result = validationResult;
        break;
      }
    }
    return result;
  }
}

class IsEmptyStringValidation extends StringValidation {
  const IsEmptyStringValidation();

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty || value.isEmpty) {
      return 'Must not be empty';
    }
    return null;
  }
}

class IsTooShortString extends StringValidation {
  final int minSize;
  const IsTooShortString({required this.minSize});

  @override
  String? validate(String? value) {
    value = value ?? '';
    if (value.length < minSize) {
      return 'Should be at least $minSize characters long (${value.length})';
    }
    return null;
  }
}

class IsTooLongString extends StringValidation {
  final int maxSize;
  const IsTooLongString({required this.maxSize});

  @override
  String? validate(String? value) {
    value = value ?? '';
    if (value.length > maxSize) {
      return 'Should be less than $maxSize characters long (${value.length})';
    }
    return null;
  }
}

class IsValidEmail extends StringValidation {
  const IsValidEmail();
  @override
  String? validate(String? value) {
    value = value ?? '';
    String toLower = value.toLowerCase();
    bool isValidFormat = toLower.contains('@') &&
        (toLower.endsWith('.com') || toLower.endsWith('.net'));

    if (isValidFormat) return null;
    return 'Invalid Email';
  }
}
