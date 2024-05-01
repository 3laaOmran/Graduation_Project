// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardingContentModel {
  String image;
  String mainText;
  String bodyText;
  OnboardingContentModel({
    required this.image,
    required this.mainText,
    required this.bodyText,
  });
}

List<OnboardingContentModel> onboardingContentList = [
  OnboardingContentModel(
    image: 'assets/images/onboarding_one.png',
    mainText: 'High\nQualityFood',
    bodyText: ' Carefully selected',
  ),
  OnboardingContentModel(
    image: 'assets/images/onboarding_two.png',
    mainText: 'Clean\nEnvironment',
    bodyText: 'Save The planet',
  ),
  OnboardingContentModel(
    image: 'assets/images/onboarding_three.png',
    mainText: 'Reduce\nFood Waste',
    bodyText: 'Reducing Famines',
  ),
];
