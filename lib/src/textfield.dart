import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as international;

class FlutterTextField extends StatefulWidget {
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final String hint;
  final double? radiusTextField;
  final double? blurRadius;
  final double? spreadRadius;
  final Offset? offset;
  final bool hasBorder;
  final bool useShadow;
  final TextInputType? textInputType;
  final bool unFocus;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final Function(String) onChanged;
  final int maxLines;
  final int maxLength;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool isPassword;
  final String? text;
  final Color? iconColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? shadowColor;

  const FlutterTextField({
    Key? key,
    this.textStyle,
    required this.hint,
    this.hasBorder = false,
    this.useShadow = false,
    this.offset,
    this.blurRadius,
    this.spreadRadius,
    this.textInputType = TextInputType.text,
    this.unFocus = false,
    this.suffixIcon,
    this.onTap,
    this.radiusTextField,
    required this.controller,
    required this.onChanged,
    this.maxLines = 1,
    this.maxLength = 64,
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    this.isPassword = false,
    this.text,
    this.iconColor,
    this.labelStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.shadowColor
  }) : super(key: key);

  @override
  _FlutterTextFieldState createState() => _FlutterTextFieldState();
}

class _FlutterTextFieldState extends State<FlutterTextField> {
  late TextDirection _textDirection;

  @override
  void initState() {
    super.initState();
    _textDirection = widget.textDirection!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget.radiusTextField ?? 10)),
        boxShadow: widget.useShadow ? [
          BoxShadow(
            color: widget.shadowColor ?? Colors.black54,
            blurRadius: widget.blurRadius ?? 1,
            spreadRadius: widget.spreadRadius ?? 1,
            offset: widget.offset ?? const Offset(0, 0),
          ),
        ] : null
      ),
      child: TextFormField(
        textDirection: _textDirection,
        maxLines: widget.maxLines,
        initialValue: widget.text,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        obscureText: widget.isPassword,
        readOnly: widget.unFocus,
        keyboardType: widget.textInputType ??
            (widget.isPassword ? TextInputType.visiblePassword : TextInputType.text),
        textInputAction: TextInputAction.next,
        onChanged: (c) {
          if (international.Bidi.detectRtlDirectionality(widget.controller.text)) {
            setState(() {
              _textDirection = TextDirection.rtl;
            });
          } else if (!international.Bidi.detectRtlDirectionality(widget.controller.text)) {
            setState(() {
              _textDirection = TextDirection.ltr;
            });
          }
          widget.onChanged(c);
        },
        onTap: () {
          if (widget.unFocus) FocusScope.of(context).unfocus();
          if (widget.onTap != null) widget.onTap!();
        },
        controller: widget.controller,
        style: widget.textStyle ?? const TextStyle(),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          labelText: widget.hint,
          suffixIcon: widget.suffixIcon is IconData
              ? Icon(
            widget.suffixIcon as IconData,
            color: widget.iconColor ?? Colors.black54,
          )
              : widget.suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: widget.hasBorder
                ? BorderSide(
              width: 0.75,
              color: widget.borderColor ?? Colors.black54,
            ) : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: widget.hasBorder
                ? BorderSide(
              color: widget.focusedBorderColor ?? Colors.black54,
            )
                : BorderSide.none,
          ),
          labelStyle: widget.labelStyle ?? const TextStyle(),
        ),
      ),
    );
  }
}
