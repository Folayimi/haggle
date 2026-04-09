import 'dart:typed_data';

import 'package:get/get.dart';

class NegotiationRoomController extends GetxController {
  final currentOffer = 32000.obs;
  final isMuted = false.obs;
  final isHandRaised = false.obs;
  final isVoiceOnly = false.obs;
  final isVideoEnabled = true.obs;
  final isGridView = false.obs;
  final role = NegotiationRole.seller.obs;
  final buyerAccepted = false.obs;
  final acceptedBuyerIds = <String>[].obs;
  final hasShownBuyerHint = false.obs;
  final roomLink = 'https://haggle.app/room/demo'.obs;
  final isFeedFrozen = false.obs;
  final sellerVideoUrl = ''.obs;
  final hasScreenshot = false.obs;
  final screenshots = <ScreenshotRef>[].obs;
  final messages = <ChatMessage>[].obs;
  final friends = <FriendContact>[
    FriendContact(
      id: 'fola',
      name: 'Ariyo Fola',
      handle: '@hagglefola',
      avatarUrl:
          'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
      isOnline: true,
    ),
    FriendContact(
      id: 'tolu',
      name: 'Tolu Aina',
      handle: '@tolu_aina',
      avatarUrl:
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=80',
      isOnline: false,
    ),
    FriendContact(
      id: 'muna',
      name: 'Muna Idris',
      handle: '@munaidris',
      avatarUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
      isOnline: true,
    ),
    FriendContact(
      id: 'zain',
      name: 'Zain Bello',
      handle: '@zainb',
      avatarUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=80',
      isOnline: false,
    ),
  ].obs;

  late final NegotiationParticipant seller;

  final participants = <NegotiationParticipant>[
    NegotiationParticipant(
      id: 'alex',
      name: 'Alex James',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=900&q=80',
      offer: 33500,
    ),
    NegotiationParticipant(
      id: 'luna',
      name: 'Luna Grace',
      imageUrl:
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=900&q=80',
      offer: 32000,
    ),
    NegotiationParticipant(
      id: 'maya',
      name: 'Maya Rose',
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=900&q=80',
      offer: 31000,
      isMuted: true,
      isHandRaised: true,
    ),
    NegotiationParticipant(
      id: 'jake',
      name: 'Jake Oliver',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=80',
      offer: 32500,
    ),
    NegotiationParticipant(
      id: 'leo',
      name: 'Leo Parker',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=900&q=80',
      offer: 31800,
    ),
    NegotiationParticipant(
      id: 'chloe',
      name: 'Chloe Rae',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
      offer: 32900,
      isMuted: true,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    seller = NegotiationParticipant(
      id: 'seller',
      name: 'Seller Live',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
      offer: currentOffer.value,
    );

    final args = Get.arguments;
    if (args is Map && args['role'] is String) {
      final roleValue = (args['role'] as String).toLowerCase();
      setRole(
        roleValue == 'buyer' ? NegotiationRole.buyer : NegotiationRole.seller,
      );
    } else if (args is Map && args['isSellerView'] is bool) {
      setRole(
        args['isSellerView'] as bool
            ? NegotiationRole.seller
            : NegotiationRole.buyer,
      );
    }
    if (args is Map && args['roomLink'] is String) {
      roomLink.value = args['roomLink'] as String;
    }
    if (args is Map && args['sellerVideoUrl'] is String) {
      sellerVideoUrl.value = args['sellerVideoUrl'] as String;
    }
  }

  void setRole(NegotiationRole value) {
    role.value = value;
    if (value == NegotiationRole.buyer) {
      isMuted.value = true;
      isVideoEnabled.value = false;
      isHandRaised.value = false;
    }
  }

  void markBuyerHintShown() {
    hasShownBuyerHint.value = true;
  }

  void toggleFeedFreeze() {
    isFeedFrozen.value = !isFeedFrozen.value;
  }

  void addScreenshot(Uint8List bytes) {
    hasScreenshot.value = true;
    screenshots.add(
      ScreenshotRef(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        label: 'Screenshot ${screenshots.length + 1}',
        createdAt: DateTime.now(),
        bytes: bytes,
      ),
    );
  }

  void clearScreenshot() {
    hasScreenshot.value = false;
  }

  void sendMessage({
    required NegotiationRole sender,
    required String text,
    ScreenshotRef? attachment,
  }) {
    messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: sender,
        text: text,
        attachment: attachment,
        createdAt: DateTime.now(),
      ),
    );
  }

  int get totalParticipants {
    if (role.value == NegotiationRole.buyer) {
      return participants.length + 2;
    }
    return participants.length + 1;
  }

  void increaseOffer() {
    currentOffer.value += 1000;
    seller.offer.value = currentOffer.value;
  }

  void decreaseOffer() {
    if (currentOffer.value > 1000) {
      currentOffer.value -= 1000;
      seller.offer.value = currentOffer.value;
    }
  }

  void toggleMute() => isMuted.value = !isMuted.value;
  void toggleHand() => isHandRaised.value = !isHandRaised.value;
  void toggleVoiceOnly() => isVoiceOnly.value = !isVoiceOnly.value;
  void toggleVideo() => isVideoEnabled.value = !isVideoEnabled.value;
  void toggleGrid() => isGridView.value = !isGridView.value;

  NegotiationParticipant? _findParticipant(String id) {
    for (final participant in participants) {
      if (participant.id == id) {
        return participant;
      }
    }
    return null;
  }

  void acceptOffer(String participantId) {
    final participant = _findParticipant(participantId);
    if (participant == null) return;
    currentOffer.value = participant.offer.value;
    seller.offer.value = currentOffer.value;
    _markAccepted(participantId);
  }

  void counterOffer(String participantId, int newOffer) {
    final participant = _findParticipant(participantId);
    if (participant == null) return;
    participant.offer.value = newOffer;
  }

  void unmuteParticipant(String participantId) {
    final participant = _findParticipant(participantId);
    if (participant == null) return;
    for (final other in participants) {
      other.isMuted.value = other.id != participantId;
    }
    participant.isHandRaised.value = false;
  }

  void toggleParticipantMute(String participantId) {
    final participant = _findParticipant(participantId);
    if (participant == null) return;
    if (participant.isMuted.value) {
      unmuteParticipant(participantId);
    } else {
      participant.isMuted.value = true;
    }
  }

  void toggleParticipantHand(String participantId) {
    final participant = _findParticipant(participantId);
    if (participant == null) return;
    participant.isHandRaised.value = !participant.isHandRaised.value;
  }

  void acceptSellerOffer() {
    buyerAccepted.value = true;
    _markAccepted('buyer');
  }

  void counterSellerOffer(int newOffer) {
    currentOffer.value = newOffer;
    seller.offer.value = newOffer;
  }

  void _markAccepted(String participantId) {
    if (!acceptedBuyerIds.contains(participantId)) {
      acceptedBuyerIds.add(participantId);
    }
  }
}

enum NegotiationRole { buyer, seller }

class NegotiationParticipant {
  NegotiationParticipant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required int offer,
    bool isMuted = false,
    bool isHandRaised = false,
  }) : offer = offer.obs,
       isMuted = isMuted.obs,
       isHandRaised = isHandRaised.obs;

  final String id;
  final String name;
  final String imageUrl;
  final RxInt offer;
  final RxBool isMuted;
  final RxBool isHandRaised;
}

class ScreenshotRef {
  ScreenshotRef({
    required this.id,
    required this.label,
    required this.createdAt,
    required this.bytes,
  });

  final String id;
  final String label;
  final DateTime createdAt;
  final Uint8List bytes;
}

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.createdAt,
    this.attachment,
  });

  final String id;
  final NegotiationRole sender;
  final String text;
  final ScreenshotRef? attachment;
  final DateTime createdAt;
}

class FriendContact {
  FriendContact({
    required this.id,
    required this.name,
    required this.handle,
    required this.avatarUrl,
    this.isOnline = false,
  });

  final String id;
  final String name;
  final String handle;
  final String avatarUrl;
  final bool isOnline;
}

// Get.toNamed(
//   Routes.NEGOTIATION_ROOM,
//   arguments: {'role': 'buyer', 'roomLink': 'https://haggle.app/room/abc123'},
// );
