import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';

extension ScaffoldHelper on BuildContext? {
  void show({required String message, Color backgroundColor = Colors.grey}) {
    if (this == null) {
      return;
    }

    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.SNACKBAR,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.redAccent,
    //   textColor: Colors.white,
    //   fontSize: 16.sp,
    // );

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp),
          ),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
          shape: const StadiumBorder(),
          margin: const EdgeInsets.only(bottom: 100, left: 40, right: 40),
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

extension GetCardLogo on String {
  String getCardSvg() {
    if (this == 'master') {
      return AppAssets.icCardMastercardSvg;
    } else if (this == 'visa') {
      return AppAssets.icCardVisaSvg;
    } else {
      return AppAssets.icCardPaypalSvg;
    }
  }
}

extension GetGenderText on int {
  String getGender() {
    if (this == 0) {
      return 'Male';
    } else if (this == 1) {
      return 'Female';
    } else {
      return 'Prefer not to say';
    }
  }
}
