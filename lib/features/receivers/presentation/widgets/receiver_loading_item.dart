import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ReceiverLoadingItem extends StatelessWidget {
  const ReceiverLoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 21,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 1.5, color: Colors.grey, indent: 22.w, endIndent: 22.w);
      },
      itemBuilder: (_, index) {
        if (index == 20) {
          return SizedBox(
            height: 28.h,
          );
        }
        // return const TransactionItem();
        return Shimmer.fromColors(
          baseColor: const Color(0xFF282A3B),
          highlightColor: const Color(0xFF45496B),
          child: ExpansionTile(
            leading: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey, width: 1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                ),
                CircleAvatar(
                  radius: 10.r,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
            title: Container(
              height: 16.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            iconColor: Colors.white,
            collapsedIconColor: const Color(0xFF818492),
          ),
        );
      },
    );
  }
}
