import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  const AudioWave({super.key, this.color = Colors.white});

  final Color color;

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final heights = [
          10 + (t * 12),
          18 + ((1 - t) * 14),
          12 + (t * 10),
          20 + ((1 - t) * 12),
        ];
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: heights
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    height: h,
                    width: 6,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
