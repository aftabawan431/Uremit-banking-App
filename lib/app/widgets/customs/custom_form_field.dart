import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.enabled,
    this.contentPadding,
    this.prefixIconPath,
    this.suffixIconPath,
    this.suffixIconOnTap,
    this.onTap,
    this.suffix,
    this.prefix,
    this.networkPrefix = false,
    this.interactiveSelection = true,
    this.maxLength,
    this.maxLengthEnforced,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final bool? maxLengthEnforced;
  final bool? enabled;
  final EdgeInsets? contentPadding;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Function()? suffixIconOnTap;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final bool networkPrefix;
  final bool interactiveSelection;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: interactiveSelection,
      readOnly: readOnly,
      enabled: enabled,
      obscureText: obscureText,
      obscuringCharacter: '●',
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      cursorHeight: 20,
      maxLines: maxLines,
      maxLength: maxLength,
      maxLengthEnforcement:maxLengthEnforced==true? MaxLengthEnforcement.enforced:MaxLengthEnforcement.none,
      onTap: onTap,
      style: GoogleFonts.openSans(
        color: const Color(0xFF000812),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),

      decoration: InputDecoration(

        hintText: hintText,
        labelText: labelText,
        contentPadding: contentPadding,
        suffixIcon: suffixIconPath == null
            ? null
            : GestureDetector(
                onTap: suffixIconOnTap,
                child: Transform.translate(
                  offset: Offset(0, -1.h),
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: SvgPicture.asset(suffixIconPath!),
                  ),
                ),
              ),
        prefixIcon: prefixIconPath == null
            ? null
            : Transform.translate(
                offset: Offset(0, -1.h),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 10.w),
                  child: networkPrefix
                      ? ClipOval(
                          child: SizedBox(
                            width: 25.w,
                            height: 25.w,
                            child: SvgPicture.network(
                              prefixIconPath!,
                              width: 25.w,
                              height: 25.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SvgPicture.asset(prefixIconPath!),
                ),
              ),
        prefixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
        suffixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
        suffix: suffix,
        prefix: prefix,
      ),
      validator: validator,
    );
  }
}
