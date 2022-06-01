import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CardLoadingItem extends StatelessWidget {
  const CardLoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 22.h);
      },
      itemBuilder: (_, index) {
        if (index == 5) {
          return SizedBox(
            height: 16.h,
          );
        }
        return Shimmer.fromColors(
          baseColor: const Color(0xFF282A3B),
          highlightColor: const Color(0xFF45496B),
          child: Container(
            height: 100.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF45496B),
                  Color(0xFF282A3B),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
