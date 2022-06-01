import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingProfileHeader extends StatelessWidget {
  const LoadingProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFAFAFA),
            Color(0xFFB4DBEC),
          ],
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 22.w),
      padding: EdgeInsets.all(10.w),
      child: SizedBox(
        width: double.infinity,
        height: 100.h,
      ),
    );
  }
}
