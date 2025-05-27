import 'package:flutter/material.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/format.dart';

//TODO: revisar ancho y alto para que entre como una hilera vertical en pantalla de celular, o sino corregir la disposicion en TypeSelectionPage
class EntryTypeButton extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onPressed;

  const EntryTypeButton({
    super.key,
    required this.name,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 200,
        width: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
        padding: const EdgeInsets.all(AppSpacing.sm),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60, width: 60, fit: BoxFit.contain),
            const SizedBox(height: AppSpacing.sm),
            Text(
              name,
              textAlign: TextAlign.center,
              style: AppTextStyles.typeButtonStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
