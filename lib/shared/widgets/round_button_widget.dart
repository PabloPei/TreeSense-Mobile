import 'package:flutter/material.dart';
import 'package:treesense/core/theme/format.dart';

class RoundButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String? imageAsset;

  const RoundButtonWidget({
    super.key,
    required this.onTap,
    required this.color,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppBorderRadius.full),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
