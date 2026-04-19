import 'package:flutter/material.dart';

class RegisterNameController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  String get name => nameController.text.trim();
  String get surname => surnameController.text.trim();

  void init() {}

  String? validate() {
    if (name.isEmpty) return 'Veuillez entrer votre nom';
    if (surname.isEmpty) return 'Veuillez entrer votre prénom';
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }
}
