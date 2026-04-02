import 'package:get/get.dart';

class NegotiationRoomController extends GetxController {
  final currentOffer = 32000.obs;
  final isMuted = false.obs;
  final isHandRaised = false.obs;

  void increaseOffer() => currentOffer.value += 1000;
  void decreaseOffer() {
    if (currentOffer.value > 1000) {
      currentOffer.value -= 1000;
    }
  }

  void toggleMute() => isMuted.value = !isMuted.value;
  void toggleHand() => isHandRaised.value = !isHandRaised.value;
}
