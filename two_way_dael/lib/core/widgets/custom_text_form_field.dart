import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? foucusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final bool isObsecureText;
  final IconData? sufixIcon;
  final Function(String)? onFieldSubmitted;
  final Function()? suffixOnPressed;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String?) validator;
  const CustomTextFormField(
      {super.key,
      this.contentPadding,
      this.foucusedBorder,
      this.enabledBorder,
      this.inputTextStyle,
      this.hintStyle,
      required this.hintText,
      required this.isObsecureText,
      this.sufixIcon,
      this.backgroundColor,
      this.controller,
      required this.validator,
      this.prefixIcon,
      this.keyboardType,
      this.borderRadius,
      this.labelText,
      this.suffixOnPressed, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      cursorColor: ColorManager.mainOrange,
      controller: controller,
      decoration: InputDecoration(
        //remove default padding
        isDense: true,

        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 20.w,
            ),
        focusedBorder: foucusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.mainOrange,
                width: 1.3,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(50.0),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.gray,
                width: 1.3,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(50.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(50.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(50.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font15GrayRegular,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(
              sufixIcon,
              color: ColorManager.mainOrange,
            )),
        prefixIcon: prefixIcon, prefixIconColor: ColorManager.mainOrange,
        fillColor: backgroundColor ?? Colors.white,
        filled: true,
      ),
      obscureText: isObsecureText,
      style: inputTextStyle ?? TextStyles.font15BlackRegular,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
