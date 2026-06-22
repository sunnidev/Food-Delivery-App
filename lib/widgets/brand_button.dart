import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const BrandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? (filled ? AppColors.button : AppColors.white);
    final fg = foregroundColor ?? (filled ? AppColors.buttonText : AppColors.primary);
    final borderColor = AppColors.white.withOpacity(0.9);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: BorderSide(color: borderColor, width: 1),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
