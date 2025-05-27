import 'package:flutter/material.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/font_conf.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.lg),
            ),
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
          child: Text(text, style: AppTextStyles.buttonStyle),
        ),
      ),
    );
  }
}
