import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../utils/router/app_state.dart';

class AuthSalutation extends StatelessWidget {
  const AuthSalutation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 22.h),

        Text('Welcome to', style: Theme.of(context).textTheme.headline5),
        SizedBox(height: 10.h),
        SvgPicture.asset(AppAssets.uremitSvg),
        SizedBox(height: 10.h),
        Text('Let\'s Transfer Payment', style: Theme.of(context).textTheme.headline5),
      ],
    );
  }
}
