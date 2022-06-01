import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBanner extends StatelessWidget {
  const LoadingBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF282A3B),
      highlightColor: const Color(0xFF45496B),
      child: Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
