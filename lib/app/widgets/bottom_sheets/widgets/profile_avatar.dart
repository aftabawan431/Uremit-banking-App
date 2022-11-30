import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';

import '../../../../utils/constants/app_level/app_assets.dart';
import '../../../../utils/constants/app_level/app_url.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 55.r,
          backgroundColor: Colors.grey,
          child: ValueListenableBuilder<File?>(
              valueListenable: context.read<HomeViewModel>().profileImgFile,
              builder: (_, profileImg, __) {
                return CircleAvatar(
                  radius: 53.r,
                  backgroundColor: Colors.white,
                  child: profileImg != null
                      ? CircleAvatar(
                          radius: 51.r,
                          backgroundColor: Colors.grey.withOpacity(0.4),
                          backgroundImage: FileImage(profileImg),
                        )
                      : context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.userImage.isEmpty
                          ? CircleAvatar(
                              radius: 35.r,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              backgroundImage: AssetImage(
                                AppAssets.defaultPicture,
                              ),
                            )
                          : CircleAvatar(
                              radius: 51.r,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              backgroundImage: CachedNetworkImageProvider(AppUrl.fileBaseUrl + context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.userImage),
                            ),
                );
              }),
        ),
        Positioned(
          bottom: 16.h,
          right: -8.w,
          child: GestureDetector(
            onTap: () async {
              await context.read<HomeViewModel>().profileImageSelector(context);

              if (context.read<HomeViewModel>().profileImgFile.value != null) {
                await context.read<HomeViewModel>().setProfileImage(context);
              }
            },
            child: SimpleShadow(
              opacity: 0.3,
              color: Colors.black12,
              offset: const Offset(0, 0),
              sigma: 10,
              child: Container(
                height: 38.w,
                width: 38.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                padding: EdgeInsets.all(8.w),
                child: SvgPicture.asset(AppAssets.icCameraSvg, color: Colors.white, height: 28.w, width: 28.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
