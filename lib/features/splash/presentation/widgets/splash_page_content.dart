import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../manager/splash_view_model.dart';

class SplashPageContent extends StatefulWidget {
  const SplashPageContent({Key? key}) : super(key: key);

  @override
  _SplashPageContentState createState() => _SplashPageContentState();
}

class _SplashPageContentState extends State<SplashPageContent> {
  @override
  void initState() {
    context.read<SplashViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<SplashViewModel>().getDeviceInfo().then((value) => context.read<SplashViewModel>().moveToAuthWrapperPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.splashBackgroundPng),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: 135.h, child: SvgPicture.asset(AppAssets.uremitLogoSvg)),
          ],
        ),
      ),
    );
  }
}
