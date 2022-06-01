import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/widgets/loading_profile_header.dart';

import '../../../../../app/globals.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../utils/constants/app_level/app_url.dart';
import '../../../../home/presentation/manager/home_view_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  HomeViewModel get _homeViewModel => sl();

  @override
  Widget build(BuildContext context) {
    // if (context.read<HomeViewModel>().profileDetailsNotifier.value.isEmpty) {
    //   return Center(
    //     child: Text('No Information found', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
    //   );
    // }
    return ValueListenableBuilder<bool>(
      valueListenable: _homeViewModel.isLoadingNotifier,
      builder: (_, value, __) {
        if (value) {
          return const LoadingProfileHeader();
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFAFAFA),
                  Color(0xFFB4DBEC),
                ],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 22.w),
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                SimpleShadow(
                  opacity: 0.6,
                  color: Colors.black12,
                  offset: const Offset(0, 0),
                  sigma: 10,
                  child: Container(
                    width: 125.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      image: DecorationImage(
                        image: context.read<HomeViewModel>().profileImgFile.value != null
                            ? FileImage(context.read<HomeViewModel>().profileImgFile.value!)
                            : context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.userImage.isEmpty
                                ? const CachedNetworkImageProvider(AppAssets.defaultPicture)
                                : CachedNetworkImageProvider(AppUrl.fileBaseUrl + context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.userImage) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_homeViewModel.profileHeader!.profileHeaderBody.first.firstName,
                          style: Theme.of(context).textTheme.subtitle2, maxLines: 1, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AppAssets.icVerifiedSvg),
                          SizedBox(width: 8.w),
                          Text('Verified', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      _detailItem(context: context, title: 'Full Name', details: _homeViewModel.profileHeader!.profileHeaderBody.first.fullName),
                      SizedBox(height: 2.h),
                      _detailItem(context: context, title: 'Email', details: _homeViewModel.profileHeader!.profileHeaderBody.first.email),
                      SizedBox(height: 2.h),
                      _detailItem(context: context, title: 'Phone Number', details: _homeViewModel.profileHeader!.profileHeaderBody.first.phoneNo),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _detailItem({required BuildContext context, required String title, required String details}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 9.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        SizedBox(width: 5.w),
        Expanded(
            child: Text(details, style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 9.sp), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end)),
      ],
    );
  }
}
