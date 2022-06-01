import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTransactionItem extends StatelessWidget {
  const LoadingTransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const TransactionItem();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int index = 0; index < 11; index++)
          Shimmer.fromColors(
            baseColor: const Color(0xFF282A3B),
            highlightColor: const Color(0xFF45496B),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 10.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 16.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ],
              ),
              iconColor: Colors.white,
              collapsedIconColor: const Color(0xFF818492),
            ),
          ),
      ],
    );
  }
}
