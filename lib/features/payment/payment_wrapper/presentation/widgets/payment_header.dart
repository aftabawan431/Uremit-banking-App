import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF99A0BA),
            Color(0xFF515E8C),
          ],
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 22.w),
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send Amount',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  '100000 AUD',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Total Fees = 180 AUD',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            AppAssets.icArrowSvg,
            height: 35.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Receiver Gets',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  '120000 Rs',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Exchange Rate = 180 PKR',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
