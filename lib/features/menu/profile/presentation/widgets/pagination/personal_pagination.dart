import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/menu/profile/presentation/manager/profile_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../../utils/constants/app_level/app_assets.dart';

class PersonalPagination extends StatelessWidget {
  const PersonalPagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Detail', style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 16.h),
          SimpleShadow(
            opacity: 0.6,
            color: Colors.black12,
            offset: const Offset(0, 0),
            sigma: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FCFF),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFD6D6D6),
                ),
              ),
              child: Column(
                children: [
                  _detailItem(
                      context: context, icon: AppAssets.icNameSvg, title: 'First Name', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.firstName),
                  const Divider(),
                  _detailItem(
                      context: context, icon: AppAssets.icNameSvg, title: 'Middle Name', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.middleName),
                  const Divider(),
                  _detailItem(
                      context: context, icon: AppAssets.icNameSvg, title: 'Last Name', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.lastName),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icCountrySvg,
                      title: 'Country of Birth',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.birthCountry),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icOccupationSvg,
                      title: 'Occupation',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.occupation),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icNationalitySvg,
                      title: 'Nationality',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.nationalityCountry),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icNameSvg,
                      title: 'Gender',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.genderId.getGender()),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icContactSvg,
                      title: 'Contact Number',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.phoneNumber),
                  const Divider(),
                  _detailItem(
                      context: context, icon: AppAssets.icCalendarSvg, title: 'Date of Birth', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.dob),
                ],
              ),
            ),
          ),
          SizedBox(height: 22.h),
          Text('Address Detail', style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 16.h),
          SimpleShadow(
            opacity: 0.6,
            color: Colors.black12,
            offset: const Offset(0, 0),
            sigma: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FCFF),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFD6D6D6),
                ),
              ),
              child: Column(
                children: [
                  _detailItem(
                      context: context, icon: AppAssets.icAddressSvg, title: 'Address Detail', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.address),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icPostalCodeSvg,
                      title: 'Post Code',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.postalCode),
                  const Divider(),
                  _detailItem(context: context, icon: AppAssets.icCitySvg, title: 'Suburb', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.city),
                  const Divider(),
                  _detailItem(
                      context: context, icon: AppAssets.icProvinceSvg, title: 'State', detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.province),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _detailItem({required BuildContext context, required String icon, required String title, required String detail}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 12.w),
        Text(title, style: Theme.of(context).textTheme.bodyText2),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(detail, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey), textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
