class ValidatePasswordUseCase {
  String? call(String password) {
    final value = password.trim();

    if (value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }

    return null;
  }
}