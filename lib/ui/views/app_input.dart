import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.height,
    this.onChange,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.focus,
    this.inputAction,
    this.inputType,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.obscure = false,
    this.hasError = false,
    this.textSize,
    this.borderRadius,
    this.focusNode,
    this.formatters,
    this.margin,
    this.align,
    this.contentPadding,
    this.filled = true,
    this.minLines = 1,
    this.validator,
    this.capitalization,
    this.suffixIconConstraint,
    required this.controller,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final bool? focus;
  final bool obscure;
  final bool hasError;
  final int maxLines;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final Function(String?)? onChange;
  final Function(String)? onFieldSubmitted;
  final Widget? suffix;
  final Widget? prefix;
  final double? textSize;
  final BorderRadius? borderRadius;
  final double? height;
  final List<TextInputFormatter>? formatters;
  final TextAlign? align;
  final EdgeInsets? contentPadding;
  final BoxConstraints? suffixIconConstraint;
  final int minLines;
  final bool filled;
  final EdgeInsets? margin;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextCapitalization? capitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  OutlineInputBorder get borderless {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextFormField(
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      controller: widget.controller,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      onChanged: widget.onChange,
      obscureText: widget.obscure,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onFieldSubmitted: widget.onFieldSubmitted,
      cursorHeight: 18,
      cursorColor: Theme.of(context).colorScheme.onBackground,
      inputFormatters: widget.formatters,
      scrollPadding: EdgeInsets.zero,
      textAlign: widget.align ?? TextAlign.start,
      validator: widget.validator,
      textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: widget.textSize ?? 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        fillColor: cs.surface,
        hintText: widget.hint,
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefix,
        border: borderless,
        enabledBorder: borderless,
        focusedBorder: borderless,
        suffixStyle:
            TextStyle(color: Theme.of(context).colorScheme.onBackground),
        suffixIconConstraints: widget.suffixIconConstraint,
        contentPadding: widget.contentPadding,
      ),
    );
  }
}
