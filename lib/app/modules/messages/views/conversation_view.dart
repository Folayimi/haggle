import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock_seller_profiles.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  SellerProfileData get seller {
    final args = Get.arguments;
    if (args is SellerProfileData) {
      return args;
    }
    return sellerProfiles.first;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final featuredProduct = seller.products.first;
    final alternateProduct = seller.products.length > 1 ? seller.products[1] : featuredProduct;
    final messages = [
      _ChatMessage.system(label: 'Today'),
      _ChatMessage.text(
        text: 'Hi, I saw your listing and wanted to ask if there is any room to negotiate.',
        isMine: true,
        time: '10:14 AM',
        readState: _ReadState.seen,
      ),
      _ChatMessage.text(
        text: 'Yes, I can work with serious buyers. Which product are you interested in?',
        isMine: false,
        time: '10:16 AM',
      ),
      _ChatMessage.product(
        product: featuredProduct,
        isMine: false,
        time: '10:17 AM',
        caption: 'Here is the main product buyers are asking about right now.',
        actionLabel: 'View seller',
      ),
      _ChatMessage.text(
        text: 'The main bundle looks great. Can we talk around the listed price if pickup is today?',
        isMine: true,
        time: '10:18 AM',
        readState: _ReadState.delivered,
      ),
      _ChatMessage.voice(
        isMine: false,
        time: '10:19 AM',
        duration: '0:18',
        wavePeaks: const [10, 16, 12, 22, 18, 11, 20, 14, 12, 19, 10, 17, 13, 21],
      ),
      _ChatMessage.text(
        text: 'That works. I can also show more details live if you want a closer look before deciding.',
        isMine: false,
        time: '10:20 AM',
      ),
      _ChatMessage.product(
        product: alternateProduct,
        isMine: true,
        time: '10:21 AM',
        caption: 'This second option could work too if the live discount applies.',
        actionLabel: 'Saved item',
        readState: _ReadState.read,
      ),
      _ChatMessage.voice(
        isMine: true,
        time: '10:23 AM',
        duration: '0:11',
        readState: _ReadState.read,
        wavePeaks: const [8, 13, 18, 11, 17, 21, 12, 16, 9, 14, 19, 10],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: AppColors.neutral),
                ),
              ),
              child: Row(
                children: [
                  _TopButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: Get.back,
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.SELLER_PROFILE, arguments: seller),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(seller.avatarUrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.SELLER_PROFILE, arguments: seller),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            seller.name,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Online now',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _TopButton(icon: Icons.call_outlined),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                itemCount: messages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final message = messages[index];
                  if (message.type == _ChatMessageType.system) {
                    return _SystemDivider(label: message.label ?? '');
                  }
                  return Align(
                    alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.78,
                      ),
                      child: _MessageBubble(
                        message: message,
                        seller: seller,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.neutral),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _ComposerIconButton(
                        icon: Icons.add_rounded,
                        backgroundColor: const Color(0xFFF7F4EF),
                        foregroundColor: AppColors.dark,
                      ),
                      const SizedBox(width: 10),
                      _ComposerIconButton(
                        icon: Icons.image_outlined,
                        backgroundColor: const Color(0xFFF7F4EF),
                        foregroundColor: AppColors.dark,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            filled: true,
                            fillColor: const Color(0xFFF7F4EF),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(color: AppColors.neutral),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: const BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const _SendButton(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      _VoiceShortcutChip(label: 'Record note'),
                      SizedBox(width: 10),
                      _VoiceShortcutChip(label: 'Share item'),
                    ],
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

enum _ChatMessageType { system, text, voice, product }

enum _ReadState { sent, delivered, seen, read }

class _ChatMessage {
  const _ChatMessage._({
    required this.type,
    required this.isMine,
    required this.time,
    this.text,
    this.duration,
    this.product,
    this.caption,
    this.readState,
    this.label,
    this.actionLabel,
    this.wavePeaks,
  });

  factory _ChatMessage.system({required String label}) {
    return _ChatMessage._(
      type: _ChatMessageType.system,
      isMine: false,
      time: '',
      label: label,
    );
  }

  factory _ChatMessage.text({
    required String text,
    required bool isMine,
    required String time,
    _ReadState? readState,
  }) {
    return _ChatMessage._(
      type: _ChatMessageType.text,
      text: text,
      isMine: isMine,
      time: time,
      readState: readState,
    );
  }

  factory _ChatMessage.voice({
    required bool isMine,
    required String time,
    required String duration,
    _ReadState? readState,
    List<double>? wavePeaks,
  }) {
    return _ChatMessage._(
      type: _ChatMessageType.voice,
      isMine: isMine,
      time: time,
      duration: duration,
      readState: readState,
      wavePeaks: wavePeaks,
    );
  }

  factory _ChatMessage.product({
    required SellerProduct product,
    required bool isMine,
    required String time,
    String? caption,
    String? actionLabel,
    _ReadState? readState,
  }) {
    return _ChatMessage._(
      type: _ChatMessageType.product,
      isMine: isMine,
      time: time,
      product: product,
      caption: caption,
      actionLabel: actionLabel,
      readState: readState,
    );
  }

  final _ChatMessageType type;
  final bool isMine;
  final String time;
  final String? text;
  final String? duration;
  final SellerProduct? product;
  final String? caption;
  final _ReadState? readState;
  final String? label;
  final String? actionLabel;
  final List<double>? wavePeaks;
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.seller,
  });

  final _ChatMessage message;
  final SellerProfileData seller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleColor = message.isMine ? AppColors.primary : Colors.white;
    final textColor = message.isMine ? Colors.white : AppColors.dark;
    final metaColor = message.isMine ? Colors.white.withOpacity(0.8) : AppColors.dark.withOpacity(0.52);

    return Container(
      padding: EdgeInsets.fromLTRB(
        14,
        12,
        14,
        message.type == _ChatMessageType.product ? 12 : 10,
      ),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(18),
        border: message.isMine ? null : Border.all(color: AppColors.neutral),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withOpacity(message.isMine ? 0.04 : 0.05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.type == _ChatMessageType.text)
            Text(
              message.text ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
                height: 1.4,
              ),
            ),
          if (message.type == _ChatMessageType.voice)
            _VoiceNoteRow(
              duration: message.duration ?? '0:00',
              isMine: message.isMine,
              wavePeaks: message.wavePeaks ?? const [10, 16, 12, 22, 18, 11, 20, 14],
            ),
          if (message.type == _ChatMessageType.product)
            _SharedProductCard(
              product: message.product!,
              caption: message.caption,
              isMine: message.isMine,
              actionLabel: message.actionLabel,
              seller: seller,
            ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message.time,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: metaColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (message.readState != null) ...[
                const SizedBox(width: 8),
                Icon(
                  _readStateIcon(message.readState!),
                  size: 14,
                  color: _readStateColor(message.readState!, message.isMine),
                ),
                const SizedBox(width: 4),
                Text(
                  _readStateLabel(message.readState!),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: metaColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  IconData _readStateIcon(_ReadState state) {
    switch (state) {
      case _ReadState.sent:
        return Icons.check_rounded;
      case _ReadState.delivered:
        return Icons.done_all_rounded;
      case _ReadState.seen:
        return Icons.done_all_rounded;
      case _ReadState.read:
        return Icons.visibility_rounded;
    }
  }

  Color _readStateColor(_ReadState state, bool isMine) {
    if (!isMine) return AppColors.dark.withOpacity(0.48);
    if (state == _ReadState.seen || state == _ReadState.read) {
      return const Color(0xFFD5F5EE);
    }
    return Colors.white.withOpacity(0.82);
  }

  String _readStateLabel(_ReadState state) {
    switch (state) {
      case _ReadState.sent:
        return 'Sent';
      case _ReadState.delivered:
        return 'Delivered';
      case _ReadState.seen:
        return 'Seen';
      case _ReadState.read:
        return 'Read';
    }
  }
}

class _VoiceNoteRow extends StatelessWidget {
  const _VoiceNoteRow({
    required this.duration,
    required this.isMine,
    required this.wavePeaks,
  });

  final String duration;
  final bool isMine;
  final List<double> wavePeaks;

  @override
  Widget build(BuildContext context) {
    final waveColor = isMine ? Colors.white.withOpacity(0.8) : AppColors.dark.withOpacity(0.42);
    final iconColor = isMine ? Colors.white : AppColors.dark;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: isMine ? Colors.white.withOpacity(0.16) : const Color(0xFFF7F4EF),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.play_arrow_rounded, color: iconColor, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: wavePeaks
                  .map(
                    (peak) => Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 3,
                          height: peak,
                          decoration: BoxDecoration(
                            color: waveColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          duration,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isMine ? Colors.white.withOpacity(0.86) : AppColors.dark.withOpacity(0.62),
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _SharedProductCard extends StatelessWidget {
  const _SharedProductCard({
    required this.product,
    required this.isMine,
    required this.seller,
    this.caption,
    this.actionLabel,
  });

  final SellerProduct product;
  final bool isMine;
  final SellerProfileData seller;
  final String? caption;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.SELLER_PROFILE, arguments: seller),
      child: Container(
        decoration: BoxDecoration(
          color: isMine ? Colors.white.withOpacity(0.12) : const Color(0xFFF9F6F1),
          borderRadius: BorderRadius.circular(16),
          border: isMine ? null : Border.all(color: AppColors.neutral),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 1.6,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (caption != null) ...[
                    Text(
                      caption!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isMine ? Colors.white.withOpacity(0.88) : AppColors.dark.withOpacity(0.72),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: isMine ? Colors.white : AppColors.dark,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isMine ? Colors.white.withOpacity(0.14) : Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          product.category,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isMine ? Colors.white : AppColors.dark.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isMine ? Colors.white.withOpacity(0.8) : AppColors.dark.withOpacity(0.68),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: isMine ? Colors.white : AppColors.dark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isMine ? Colors.white.withOpacity(0.14) : AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          actionLabel ?? 'Open item',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: isMine ? Colors.white : AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
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

class _SystemDivider extends StatelessWidget {
  const _SystemDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.neutral),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.dark.withOpacity(0.62),
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F4EF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: AppColors.dark),
        ),
      ),
    );
  }
}

class _ComposerIconButton extends StatelessWidget {
  const _ComposerIconButton({
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: foregroundColor),
    );
  }
}

class _VoiceShortcutChip extends StatelessWidget {
  const _VoiceShortcutChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4EF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.neutral),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.mic_none_rounded, size: 16, color: AppColors.dark),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.dark,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
    );
  }
}
