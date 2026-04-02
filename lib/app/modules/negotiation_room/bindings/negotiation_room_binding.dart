import 'package:get/get.dart';

import '../controllers/negotiation_room_controller.dart';

class NegotiationRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NegotiationRoomController>(() => NegotiationRoomController());
  }
}
