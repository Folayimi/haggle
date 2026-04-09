import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../theme/app_colors.dart';
import '../controllers/negotiation_room_controller.dart';

class NegotiationRoomView extends GetView<NegotiationRoomController> {
  NegotiationRoomView({super.key});

  final GlobalKey _feedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    _maybeShowBuyerHint(context);
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Obx(
        () => controller.role.value == NegotiationRole.seller
            ? _ShippingListDrawer(
                acceptedBuyerIds: controller.acceptedBuyerIds,
                participants: controller.participants,
              )
            : const SizedBox.shrink(),
      ),
      backgroundColor: const Color(0xFF0E0E18),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF121225), Color(0xFF1E1436), Color(0xFF10101A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                child: Row(
                  children: [
                    _CircleIconButton(
                      icon: Icons.chevron_left,
                      onTap: () => Get.back(),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF4D4D),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '22:24:55',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(
                          () => _ParticipantCountPill(
                            count: controller.totalParticipants,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Obx(
                      () => controller.role.value == NegotiationRole.seller
                          ? _CircleIconButton(
                              icon: Icons.shopping_cart_outlined,
                              onTap: () => scaffoldKey.currentState?.openEndDrawer(),
                            )
                          : _CircleIconButton(
                              icon: Icons.share_outlined,
                              onTap: () => _shareRoomLink(context),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Obx(
                    () => controller.role.value == NegotiationRole.seller
                        ? GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.68,
                            ),
                            itemCount: controller.participants.length,
                            itemBuilder: (context, index) {
                              final participant = controller.participants[index];
                              return _VideoTile(
                                participant: participant,
                                onMenuTap: (tapPosition) =>
                                    _showParticipantMenu(context, participant, tapPosition),
                              );
                            },
                          )
                        : _BuyerStage(
                            controller: controller,
                            seller: controller.seller,
                            isSelfVideoOn: controller.isVideoEnabled.value,
                            onMakeOffer: () => _showBuyerOfferDialog(context),
                            onCaptureScreenshot: () => _captureScreenshot(context),
                            onOpenScreenshotChat: () => _openChatBottomSheet(context),
                            feedKey: _feedKey,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 2, 18, 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C2A).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => controller.role.value == NegotiationRole.buyer
                            ? _ControlButton(
                                icon: Icons.mic_off,
                                isActive: false,
                              )
                            : _ControlButton(
                                icon: controller.isMuted.value ? Icons.mic_off : Icons.mic,
                                isActive: !controller.isMuted.value,
                                onTap: controller.toggleMute,
                              ),
                      ),
                      Obx(
                        () => _ControlButton(
                          icon: controller.isVideoEnabled.value ? Icons.videocam : Icons.videocam_off,
                          isActive: controller.isVideoEnabled.value,
                          onTap: controller.toggleVideo,
                        ),
                      ),
                      Obx(
                        () => controller.role.value == NegotiationRole.buyer
                            ? _ControlButton(
                                icon: controller.isHandRaised.value
                                    ? Icons.back_hand
                                    : Icons.pan_tool_outlined,
                                isActive: controller.isHandRaised.value,
                                onTap: controller.toggleHand,
                              )
                            : const SizedBox(width: 44, height: 44),
                      ),
                      _ControlButton(
                        icon: Icons.call_end,
                        isActive: true,
                        background: AppColors.danger,
                        iconColor: Colors.white,
                        onTap: () {},
                      ),
                      Obx(
                        () => controller.role.value == NegotiationRole.buyer
                            ? _MakeOfferButton(onTap: () => _showBuyerOfferDialog(context))
                            : _ControlButton(
                                icon: Icons.more_horiz,
                                isActive: false,
                                onTap: () => _showMoreMenu(context),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showParticipantMenu(
    BuildContext context,
    NegotiationParticipant participant,
    Offset tapPosition,
  ) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final selection = await showMenu<_ParticipantMenuAction>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 1, 1),
        Offset.zero & overlay.size,
      ),
      color: const Color(0xFF202030),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      items: [
        PopupMenuItem<_ParticipantMenuAction>(
          enabled: false,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participant.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Offer: NGN ${participant.offer.value}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const PopupMenuDivider(height: 8),
        const PopupMenuItem<_ParticipantMenuAction>(
          value: _ParticipantMenuAction.accept,
          child: _MenuRow(
            icon: Icons.check_circle_outline,
            label: 'Accept offer',
          ),
        ),
        const PopupMenuItem<_ParticipantMenuAction>(
          value: _ParticipantMenuAction.counter,
          child: _MenuRow(
            icon: Icons.swap_horiz,
            label: 'Counter offer',
          ),
        ),
        if (participant.isHandRaised.value)
          const PopupMenuItem<_ParticipantMenuAction>(
            value: _ParticipantMenuAction.unmute,
            child: _MenuRow(
              icon: Icons.mic,
              label: 'Unmute to speak',
            ),
          ),
      ],
    );

    if (selection == null) return;
    switch (selection) {
      case _ParticipantMenuAction.accept:
        controller.acceptOffer(participant.id);
        break;
      case _ParticipantMenuAction.counter:
        await _showCounterDialog(context, participant);
        break;
      case _ParticipantMenuAction.unmute:
        controller.unmuteParticipant(participant.id);
        break;
    }
  }

  Future<void> _showBuyerOfferDialog(BuildContext context) async {
    final offerController = TextEditingController(
      text: controller.currentOffer.value.toString(),
    );
    final action = await showDialog<_BuyerOfferAction>(
      context: context,
      builder: (context) {
        double sliderValue = controller.currentOffer.value.toDouble();
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: const Color(0xFF1C1C2A),
            title: const Text(
              'Seller Offer',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    'Current offer: NGN ${controller.currentOffer.value}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Counter offer',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: offerController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Enter your price',
                    hintStyle: TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.tune, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Adjust with slider (optional)',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
                Slider(
                  value: sliderValue,
                  min: 1000,
                  max: 100000,
                  divisions: 99,
                  onChanged: (value) {
                    setState(() => sliderValue = value);
                    offerController.text = value.round().toString();
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(_BuyerOfferAction.counter),
                child: const Text('Send Counter'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(_BuyerOfferAction.accept),
                child: const Text('Accept'),
              ),
            ],
          ),
        );
      },
    );

    if (action == null) return;
    if (action == _BuyerOfferAction.accept) {
      controller.acceptSellerOffer();
      return;
    }

    final value = int.tryParse(offerController.text.replaceAll(',', ''));
    if (value != null) {
      controller.counterSellerOffer(value);
    }
  }

  Future<void> _showCounterDialog(
    BuildContext context,
    NegotiationParticipant participant,
  ) async {
    final controllerText = TextEditingController(
      text: participant.offer.value.toString(),
    );
    final newOffer = await showDialog<int>(
      context: context,
      builder: (context) {
        double sliderValue = participant.offer.value.toDouble();
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: const Color(0xFF1C1C2A),
            title: Text(
              'Counter ${participant.name}',
              style: const TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controllerText,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Enter new offer',
                    hintStyle: TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.tune, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Adjust with slider (optional)',
                      style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
                Slider(
                  value: sliderValue,
                  min: 1000,
                  max: 100000,
                  divisions: 99,
                  onChanged: (value) {
                    setState(() => sliderValue = value);
                    controllerText.text = value.round().toString();
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final value = int.tryParse(controllerText.text.replaceAll(',', ''));
                  if (value == null) return;
                  Navigator.of(context).pop(value);
                },
                child: const Text('Send'),
              ),
            ],
          ),
        );
      },
    );

    if (newOffer != null) {
      controller.counterOffer(participant.id, newOffer);
    }
  }

  void _maybeShowBuyerHint(BuildContext context) {
    if (controller.role.value != NegotiationRole.buyer) return;
    if (controller.hasShownBuyerHint.value) return;
    controller.markBuyerHintShown();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      final controllerSnack = messenger.showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: const Color(0xFF202030),
          content: Row(
            children: [
              const Icon(Icons.back_hand, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Tip: Raise your hand if you want to speak.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 5));
      controllerSnack.close();
    });
  }

  void _shareRoomLink(BuildContext context) {
    final link = controller.roomLink.value;
    if (link.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No room link available right now.')),
      );
      return;
    }
    Share.share('Join my negotiation room: $link');
  }

  void _captureScreenshot(BuildContext context) {
    _captureFromBoundary(context);
  }

  Future<void> _captureFromBoundary(BuildContext context) async {
    final boundary = _feedKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to capture screenshot right now.')),
      );
      return;
    }
    try {
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      controller.addScreenshot(pngBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Screenshot captured.')),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Screenshot failed. Try again.')),
      );
    }
  }

  void _openChatBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151522),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ChatBottomSheet(controller: controller),
    );
  }

  Future<void> _showMoreMenu(BuildContext context) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final selection = await showMenu<_MoreMenuAction>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(overlay.size.width - 60, overlay.size.height - 120, 1, 1),
        Offset.zero & overlay.size,
      ),
      color: const Color(0xFF202030),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      items: const [
        PopupMenuItem<_MoreMenuAction>(
          value: _MoreMenuAction.switchCamera,
          child: _MenuRow(icon: Icons.cameraswitch, label: 'Switch camera'),
        ),
        PopupMenuItem<_MoreMenuAction>(
          value: _MoreMenuAction.sendInvite,
          child: _MenuRow(icon: Icons.person_add_alt_1, label: 'Send invite'),
        ),
        PopupMenuItem<_MoreMenuAction>(
          value: _MoreMenuAction.speaker,
          child: _MenuRow(icon: Icons.volume_up_outlined, label: 'Speaker'),
        ),
        PopupMenuItem<_MoreMenuAction>(
          value: _MoreMenuAction.report,
          child: _MenuRow(icon: Icons.flag_outlined, label: 'Report'),
        ),
      ],
    );

    if (selection == null) return;
    if (selection == _MoreMenuAction.sendInvite) {
      _showInviteOptions(context);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: ${selection.label}')),
    );
  }

  void _showInviteOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1B1B2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send Invite',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.contacts, color: Colors.white),
                title: const Text('Contacts list', style: TextStyle(color: Colors.white)),
                subtitle: const Text(
                  'Invite registered buyers or friends',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _openContactsPicker(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined, color: Colors.white),
                title: const Text('Share sheet', style: TextStyle(color: Colors.white)),
                subtitle: const Text(
                  'Send link to any app',
                  style: TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _shareRoomLink(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openContactsPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151522),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final selected = <String>{};
        return StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Friends & Followers',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Obx(
                      () {
                        final total = controller.friends.length;
                        final isAllSelected = selected.length == total && total > 0;
                        return TextButton(
                          onPressed: total == 0
                              ? null
                              : () {
                                  setState(() {
                                    if (isAllSelected) {
                                      selected.clear();
                                    } else {
                                      selected
                                        ..clear()
                                        ..addAll(controller.friends.map((f) => f.id));
                                    }
                                  });
                                },
                          child: Text(isAllSelected ? 'Clear all' : 'Select all'),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 360,
                  child: Obx(
                    () => ListView.separated(
                      itemCount: controller.friends.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.white12, height: 1),
                      itemBuilder: (context, index) {
                        final friend = controller.friends[index];
                        final isSelected = selected.contains(friend.id);
                        return ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(friend.avatarUrl),
                              ),
                              if (friend.isOnline)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF52D48A),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFF151522)),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(friend.name, style: const TextStyle(color: Colors.white)),
                          subtitle:
                              Text(friend.handle, style: const TextStyle(color: Colors.white70)),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  selected.add(friend.id);
                                } else {
                                  selected.remove(friend.id);
                                }
                              });
                            },
                            activeColor: const Color(0xFF6B4EFF),
                          ),
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selected.remove(friend.id);
                              } else {
                                selected.add(friend.id);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selected.isEmpty
                        ? null
                        : () {
                            final count = selected.length;
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Invites sent to $count contact(s).')),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4EFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Send invites'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.isActive,
    this.background,
    this.iconColor,
    this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final Color? background;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: background ?? (isActive ? Colors.white : Colors.white.withOpacity(0.12)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor ?? (isActive ? const Color(0xFF171725) : Colors.white),
        ),
      ),
    );
  }
}

class _ParticipantCountPill extends StatelessWidget {
  const _ParticipantCountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.groups_rounded, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            '$count',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _MakeOfferButton extends StatelessWidget {
  const _MakeOfferButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            'Make offer',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF141421),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}

class _FreezeChatControls extends StatelessWidget {
  const _FreezeChatControls({
    required this.controller,
    required this.onFreezeToggle,
    required this.onCapture,
    required this.onCancel,
    required this.onOpenChat,
  });

  final NegotiationRoomController controller;
  final VoidCallback onFreezeToggle;
  final VoidCallback onCapture;
  final VoidCallback onCancel;
  final VoidCallback onOpenChat;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isFrozen = controller.isFeedFrozen.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isFrozen)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: onCapture,
                      child: const Text('Screenshot'),
                    ),
                    const SizedBox(width: 6),
                    TextButton(
                      onPressed: onCancel,
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MiniCircleButton(
                  icon: isFrozen ? Icons.pause_circle_filled : Icons.pause_circle_outline,
                  onTap: onFreezeToggle,
                ),
                const SizedBox(width: 8),
                _MiniCircleButton(
                  icon: Icons.chat_bubble_outline,
                  onTap: onOpenChat,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _MiniCircleButton extends StatelessWidget {
  const _MiniCircleButton({
    required this.icon,
    required this.onTap,
    this.isDisabled = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(isDisabled ? 0.3 : 0.55),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _ChatBottomSheet extends StatefulWidget {
  const _ChatBottomSheet({required this.controller});

  final NegotiationRoomController controller;

  @override
  State<_ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<_ChatBottomSheet> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Negotiation Chat',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 280,
            child: Obx(
              () => ListView.builder(
                itemCount: widget.controller.messages.length,
                itemBuilder: (context, index) {
                  final message = widget.controller.messages[index];
                  final isMe = message.sender == widget.controller.role.value;
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isMe ? const Color(0xFF6B4EFF) : const Color(0xFF242437),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          if (message.attachment != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.photo, color: Colors.white, size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    message.attachment!.label,
                                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          if (message.text.isNotEmpty) ...[
                            if (message.attachment != null) const SizedBox(height: 6),
                            Text(
                              message.text,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          _ChatComposer(
            controller: widget.controller,
            messageController: _messageController,
          ),
        ],
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({
    required this.controller,
    required this.messageController,
  });

  final NegotiationRoomController controller;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isBuyerMuted =
            controller.role.value == NegotiationRole.buyer && controller.isMuted.value;
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => _openScreenshotPicker(context),
                  icon: const Icon(Icons.attach_file, color: Colors.white),
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF222234),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: isBuyerMuted ? null : () => _sendTextMessage(context),
                  icon: Icon(
                    Icons.send,
                    color: isBuyerMuted ? Colors.white24 : Colors.white,
                  ),
                ),
              ],
            ),
            if (isBuyerMuted)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: const [
                    Icon(Icons.mic_off, color: Colors.white54, size: 14),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'You can send messages after the seller unmutes you.',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  void _sendTextMessage(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    controller.sendMessage(sender: controller.role.value, text: text);
    messageController.clear();
  }

  void _openScreenshotPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1B1B2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Obx(
        () {
          final shots = controller.screenshots;
          final isBuyerMuted =
              controller.role.value == NegotiationRole.buyer && controller.isMuted.value;
          if (shots.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'No screenshots yet',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Freeze the feed and tap Screenshot to capture a reference.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: shots.length,
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.white12, height: 1),
            itemBuilder: (context, index) {
              final shot = shots[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    shot.bytes,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(shot.label, style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                  shot.createdAt.toLocal().toString(),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                trailing: Icon(
                  Icons.send,
                  color: isBuyerMuted ? Colors.white24 : Colors.white70,
                  size: 18,
                ),
                onTap: () {
                  if (isBuyerMuted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You can send after the seller unmutes you.'),
                      ),
                    );
                    return;
                  }
                  controller.sendMessage(
                    sender: controller.role.value,
                    text: 'Reference screenshot attached.',
                    attachment: shot,
                  );
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _BuyerStage extends StatelessWidget {
  const _BuyerStage({
    required this.controller,
    required this.seller,
    required this.isSelfVideoOn,
    required this.onMakeOffer,
    required this.onCaptureScreenshot,
    required this.onOpenScreenshotChat,
    required this.feedKey,
  });

  final NegotiationRoomController controller;
  final NegotiationParticipant seller;
  final bool isSelfVideoOn;
  final VoidCallback onMakeOffer;
  final VoidCallback onCaptureScreenshot;
  final VoidCallback onOpenScreenshotChat;
  final GlobalKey feedKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _BuyerSellerTile(
            controller: controller,
            seller: seller,
            onMakeOffer: onMakeOffer,
            feedKey: feedKey,
          ),
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: _FreezeChatControls(
            controller: controller,
            onFreezeToggle: controller.toggleFeedFreeze,
            onCapture: onCaptureScreenshot,
            onCancel: controller.toggleFeedFreeze,
            onOpenChat: onOpenScreenshotChat,
          ),
        ),
        if (isSelfVideoOn)
          Positioned(
            right: 12,
            top: 12,
            child: SizedBox(
              height: 140,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BuyerSellerTile extends StatelessWidget {
  const _BuyerSellerTile({
    required this.controller,
    required this.seller,
    required this.onMakeOffer,
    required this.feedKey,
  });

  final NegotiationRoomController controller;
  final NegotiationParticipant seller;
  final VoidCallback onMakeOffer;
  final GlobalKey feedKey;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: RepaintBoundary(
        key: feedKey,
        child: Stack(
          children: [
            Positioned.fill(
              child: Obx(
                () => _SellerVideoBackground(
                  videoUrl: controller.sellerVideoUrl.value,
                  fallbackImageUrl: seller.imageUrl,
                ),
              ),
            ),
          Obx(
            () => controller.isFeedFrozen.value
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'Feed frozen',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: ElevatedButton(
              onPressed: onMakeOffer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF141421),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              child: const Text(
                'Make offer',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 14,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(seller.imageUrl),
                ),
                const SizedBox(width: 8),
                Text(
                  seller.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _SellerVideoBackground extends StatefulWidget {
  const _SellerVideoBackground({
    required this.videoUrl,
    required this.fallbackImageUrl,
  });

  final String videoUrl;
  final String fallbackImageUrl;

  @override
  State<_SellerVideoBackground> createState() => _SellerVideoBackgroundState();
}

class _SellerVideoBackgroundState extends State<_SellerVideoBackground> {
  VideoPlayerController? _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initController(widget.videoUrl);
  }

  @override
  void didUpdateWidget(covariant _SellerVideoBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.dispose();
      _controller = null;
      _hasError = false;
      _initController(widget.videoUrl);
    }
  }

  void _initController(String url) {
    if (url.isEmpty) return;
    final controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..setLooping(true)
      ..setVolume(0);
    _controller = controller;
    controller.initialize().then((_) {
      if (!mounted) return;
      controller.play();
      setState(() {});
    }).catchError((_) {
      if (!mounted) return;
      setState(() => _hasError = true);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (widget.videoUrl.isEmpty || _hasError || controller == null) {
      return Image.network(widget.fallbackImageUrl, fit: BoxFit.cover);
    }

    if (!controller.value.isInitialized) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: const SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({
    required this.participant,
    required this.onMenuTap,
  });

  final NegotiationParticipant participant;
  final ValueChanged<Offset> onMenuTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              participant.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.75),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTapDown: (details) => onMenuTap(details.globalPosition),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.more_horiz, color: Colors.white, size: 18),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Obx(
              () => participant.isHandRaised.value
                  ? Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.back_hand, color: Colors.white, size: 14),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(participant.imageUrl),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    participant.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                Obx(
                  () => Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      participant.isMuted.value ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _ParticipantMenuAction { accept, counter, unmute }
enum _BuyerOfferAction { accept, counter }
enum _MoreMenuAction { switchCamera, sendInvite, speaker, report }

extension _MoreMenuActionLabel on _MoreMenuAction {
  String get label {
    switch (this) {
      case _MoreMenuAction.switchCamera:
        return 'Switch camera';
      case _MoreMenuAction.sendInvite:
        return 'Send invite';
      case _MoreMenuAction.speaker:
        return 'Speaker';
      case _MoreMenuAction.report:
        return 'Report';
    }
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class _ShippingListDrawer extends StatelessWidget {
  const _ShippingListDrawer({
    required this.acceptedBuyerIds,
    required this.participants,
  });

  final RxList<String> acceptedBuyerIds;
  final RxList<NegotiationParticipant> participants;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A28),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping List',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Buyers who accepted the offer',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () {
                    final accepted = acceptedBuyerIds.toList();
                    if (accepted.isEmpty) {
                      return Center(
                        child: Text(
                          'No accepted buyers yet.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white54),
                        ),
                      );
                    }
                    final acceptedParticipants = participants
                        .where((participant) => accepted.contains(participant.id))
                        .toList();
                    return ListView.separated(
                      itemCount: acceptedParticipants.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.white12,
                        height: 16,
                      ),
                      itemBuilder: (context, index) {
                        final participant = acceptedParticipants[index];
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(participant.imageUrl),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    participant.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Obx(
                                    () => Text(
                                      'Accepted NGN ${participant.offer.value}',
                                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.check_circle, color: Color(0xFF52D48A), size: 20),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
