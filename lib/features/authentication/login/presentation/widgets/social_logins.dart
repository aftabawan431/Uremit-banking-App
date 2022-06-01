import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 22.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 1.5,
                endIndent: 10.w,
              ),
            ),
            Text('Or continue with', style: Theme.of(context).textTheme.caption),
            Expanded(
              child: Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 1.5,
                indent: 10.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 22.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.googleIconSvg, width: 16.w, height: 16.w),
              label: Text('Google', style: Theme.of(context).textTheme.button?.copyWith(color: Colors.grey, fontSize: 12.sp)),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.facebookIconSvg, width: 16.w, height: 16.w),
              label: Text('Facebook', style: Theme.of(context).textTheme.button?.copyWith(color: Colors.grey, fontSize: 12.sp)),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.appleIconSvg, width: 16.w, height: 16.w),
              label: Text('Apple', style: Theme.of(context).textTheme.button?.copyWith(color: Colors.grey, fontSize: 12.sp)),
            ),
          ],
        ),
      ],
    );
  }
}
