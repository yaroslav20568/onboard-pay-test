import 'package:app/constants/index.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { primary, outline }

class Button extends StatelessWidget {
  const Button({
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;

  Color _getBackgroundColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.outline:
        return AppColors.transparent;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.white;
      case ButtonVariant.outline:
        return AppColors.primary;
    }
  }

  Color? _getBorderColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return null;
      case ButtonVariant.outline:
        return AppColors.primary;
    }
  }

  Color _getDisabledBackgroundColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary.withValues(alpha: AppColors.disabledOpacity);
      case ButtonVariant.outline:
        return AppColors.transparent;
    }
  }

  Color _getDisabledForegroundColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.white.withValues(alpha: AppColors.disabledOpacity);
      case ButtonVariant.outline:
        return AppColors.primary.withValues(alpha: AppColors.disabledOpacity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = onPressed == null
        ? _getDisabledBackgroundColor(context)
        : _getBackgroundColor(context);
    final foregroundColor = onPressed == null
        ? _getDisabledForegroundColor(context)
        : _getForegroundColor(context);
    final borderColor = _getBorderColor(context);

    if (variant == ButtonVariant.outline) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: onPressed == null
                ? borderColor?.withValues(alpha: AppColors.disabledOpacity) ??
                      AppColors.transparent
                : borderColor ?? AppColors.transparent,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(foregroundColor),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: child,
    );
  }
}
