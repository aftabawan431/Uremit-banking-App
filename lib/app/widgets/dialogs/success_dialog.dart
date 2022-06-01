import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/app_level/app_assets.dart';

class SuccessDialog {
  final BuildContext context;

  SuccessDialog(this.context);

  Future show() {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 64.w,
            padding: EdgeInsets.symmetric(vertical: 64.h),
            height: 400.h,
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage(AppAssets.successDialogBackgroundPng), alignment: Alignment.center, fit: BoxFit.cover),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                SvgPicture.asset(AppAssets.icSuccessSvg, width: 56.w),
                SizedBox(height: 16.h),
                Text('Success', style: Theme.of(context).textTheme.headline4),
                const Spacer(),
                Text('Your Password has been Updated Successfully!', style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
      animationType: DialogTransitionType.fadeScale,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void hideDialog() {
    Navigator.of(context).pop();
  }
}
