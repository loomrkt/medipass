class BiometricState {
  final bool isAvailable;
  final bool hasFaceRecognition;

  const BiometricState({
    required this.isAvailable,
    required this.hasFaceRecognition,
  });

  const BiometricState.empty()
      : isAvailable = false,
        hasFaceRecognition = false;
}