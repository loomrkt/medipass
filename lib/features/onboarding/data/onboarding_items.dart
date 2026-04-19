class OnboardingItem {
  final String image;
  final String title;
  final String description;
  final String buttonText;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

const List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    image: 'assets/images/onboard_1.png',
    title: 'Connecté à votre santé',
    description:
        'Rester proche de vos professionnels et de connaitre plus sur votre santé.',
    buttonText: 'Génial, et quoi d\'autre ?',
  ),
  OnboardingItem(
    image: 'assets/images/onboard_2.png',
    title: 'Échangez en confiance',
    description: 'Une communication simple, rapide et sécurisée.',
    buttonText: 'Intéressant... et ensuite ?',
  ),
  OnboardingItem(
    image: 'assets/images/onboard_3.png',
    title: 'Tout au même endroit',
    description: 'Médecins, patients et laboratoires connectés.',
    buttonText: 'Je commence',
  ),
];