import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';

class LocalLogins extends StatelessWidget {
  const LocalLogins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 34.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox.shrink(),
            SvgPicture.asset(AppAssets.unlockFingerSvg),
            SvgPicture.asset(AppAssets.unlockFaceSvg),
            const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
