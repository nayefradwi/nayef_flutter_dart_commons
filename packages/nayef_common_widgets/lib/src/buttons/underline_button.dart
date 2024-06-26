import 'package:flutter/material.dart';
import 'package:nayef_common_widgets/src/buttons/button_loading_indicator.dart';
import 'package:nayef_common_widgets/src/context_extension.dart';

class UnderlineButton extends StatelessWidget {
  final bool isLoading;
  final String label;
  final void Function()? onClick;
  final double progressSize;
  final double progressStrokeWidth;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Color? foregroundColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  const UnderlineButton({
    required this.label,
    super.key,
    this.onClick,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.progressSize = 12,
    this.progressStrokeWidth = 2,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.foregroundColor,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
  })  : assert(
          prefixIcon == null || prefix == null,
          'You can only provide either prefixIcon or prefix, not both',
        ),
        assert(
          suffixIcon == null || suffix == null,
          'You can only provide either suffixIcon or suffix, not both',
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: _PrimaryButton(
        onClick: onClick,
        isLoading: isLoading,
        progressSize: progressSize,
        progressStrokeWidth: progressStrokeWidth,
        foregroundColor: foregroundColor ?? context.colorScheme.primary,
        child: _ButtonRowRow(
          prefixIcon: prefixIcon,
          label: label,
          fontSize: fontSize,
          fontWeight: fontWeight,
          prefix: prefix,
          suffix: suffix,
          suffixIcon: suffixIcon,
          foregroundColor: foregroundColor ?? context.colorScheme.primary,
        ),
      ),
    );
  }
}

class _ButtonRowRow extends StatelessWidget {
  const _ButtonRowRow({
    required this.prefixIcon,
    required this.label,
    required this.fontSize,
    required this.fontWeight,
    required this.foregroundColor,
    this.prefix,
    this.suffixIcon,
    this.suffix,
  });

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 4),
        if (prefixIcon != null) Icon(prefixIcon, size: 20),
        if (prefix != null) prefix!,
        if (prefix != null || prefixIcon != null) const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: foregroundColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        if (suffix != null || suffixIcon != null) const SizedBox(width: 4),
        if (suffixIcon != null) Icon(suffixIcon, size: 20),
        if (suffix != null) suffix!,
        const SizedBox(width: 4),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.onClick,
    required this.isLoading,
    required this.progressSize,
    required this.progressStrokeWidth,
    required this.child,
    required this.foregroundColor,
  });

  final void Function()? onClick;
  final bool isLoading;
  final double progressSize;
  final double progressStrokeWidth;
  final Widget child;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onClick,
      child: isLoading
          ? ButtonLoadingIndicator(
              progressSize: progressSize,
              progressStrokeWidth: progressStrokeWidth,
              foregroundColor: foregroundColor,
            )
          : child,
    );
  }
}
