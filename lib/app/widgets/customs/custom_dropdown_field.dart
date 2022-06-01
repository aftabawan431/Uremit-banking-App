import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    required this.hintText,
    required this.labelText,
    required this.items,
    this.onChanged,
    this.value,
    this.validator,
    this.onTap,
    this.loadingNotifier,
    this.contentPadding,
    this.prefixIconPath,
    this.suffixIconPath,
    this.suffixIconOnTap,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final String? value;
  final List<String> items;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final ValueNotifier<bool>? loadingNotifier;
  final Function()? onTap;
  final EdgeInsets? contentPadding;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final Function()? suffixIconOnTap;

  @override
  Widget build(BuildContext context) {
    if (loadingNotifier == null) {
      return DropdownButtonFormField<String>(
        dropdownColor: const Color(0xFFF2F2F4),
        isExpanded: true,
        isDense: true,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        value: value,
        icon: Icon(Icons.expand_more_rounded, color: Theme.of(context).canvasColor),
        onChanged: onChanged,
        validator: validator,
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
                    child: SvgPicture.asset(prefixIconPath!),
                  ),
                ),
          prefixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
          suffixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
        ),
      );
    } else {
      return ValueListenableBuilder<bool>(
        valueListenable: loadingNotifier!,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return DropdownButtonFormField<CircularProgressIndicator>(
              dropdownColor: const Color(0xFFF2F2F4),
              isExpanded: true,
              isDense: true,
              onTap: onTap,
              items: [
                DropdownMenuItem<CircularProgressIndicator>(
                  value: const CircularProgressIndicator(),
                  enabled: false,
                  child: SizedBox(
                    height: 75.h,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
              onChanged: (value) {},
              icon: Icon(Icons.expand_more_rounded, color: Theme.of(context).canvasColor),
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
                          child: SvgPicture.asset(prefixIconPath!),
                        ),
                      ),
                prefixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
                suffixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
              ),
            );
          } else {
            return DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFFF2F2F4),
              isExpanded: true,
              isDense: true,
              value: value,
              onTap: onTap,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              icon: Icon(Icons.expand_more_rounded, color: Theme.of(context).canvasColor),
              onChanged: onChanged,
              validator: validator,
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
                          child: SvgPicture.asset(prefixIconPath!),
                        ),
                      ),
                prefixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
                suffixIconConstraints: BoxConstraints(minWidth: 24.w, minHeight: 24.w),
              ),
            );
          }
        },
      );
    }
  }
}
