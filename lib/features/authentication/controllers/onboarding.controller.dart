import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // Update current Index when page scroll
  void updatePageIndicator(index) {}

  // Jump to specific dot selected page
  void dotNavigationClick(index) {}

  /// Update Current Index & jump to next page
  void nextPage() {}

  /// Update Current Index & jump to the Last Page
  void skipPage() {}
}
