class ValidateEmailUseCase {
  String? call(String email) {
    final value = email.trim();

    if (value.isEmpty) {
      return 'Veuillez entrer votre email';
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }

    return null;
  }
}