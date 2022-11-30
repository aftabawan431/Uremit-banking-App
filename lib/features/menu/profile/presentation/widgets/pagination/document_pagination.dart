import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../manager/profile_view_model.dart';

class DocumentPagination extends StatelessWidget {
  const DocumentPagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Document Information', style: Theme.of(context).textTheme.headline6),
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
                      context: context,
                      icon: AppAssets.icDocumentTypeSvg,
                      title: 'Document Type',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.attachment1Type),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icDocumentNumberSvg,
                      title: 'Document Number',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.documentNumber),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icCalendarSvg,
                      title: 'Expiry Date',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.expiryDate),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icAuthoritySvg,
                      title: 'Issuing Authority',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.issuingAuthority),
                  const Divider(),
                  _detailItem(
                      context: context,
                      icon: AppAssets.icCountrySvg,
                      title: 'Issuing Country',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.issuingCountry),
                  const Divider(),
                  _detailPictureItem(
                      context: context,
                      icon: AppAssets.icDocumentTypeSvg,
                      // title: 'Front Side: ${context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.frontFileName}',
                      title: 'Front Side: Image',
                      imagePath: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.frontFilePath.isEmpty
                          ? AppAssets.carouselPlaceholderPng
                          : AppUrl.fileBaseUrl + context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.frontFilePath),
                  const Divider(),
                  _detailPictureItem(
                      context: context,
                      icon: AppAssets.icDocumentTypeSvg,
                      // title: 'Back Side: ${context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.backFileName}',
                      title: 'Back Side: Image',
                      imagePath: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.backFilePath.isEmpty
                          ? AppAssets.carouselPlaceholderPng
                          : AppUrl.fileBaseUrl + context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.backFilePath),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(5.r)),
            child: Text('Utility Bill Document Information', style: Theme.of(context).textTheme.subtitle2),
          ),
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
                      context: context,
                      icon: AppAssets.icDocumentTypeSvg,
                      title: 'Document Type',
                      detail: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.attachment2Type),
                  const Divider(),
                  _detailPictureItem(
                      onTap: () {},
                      context: context,
                      icon: AppAssets.icDocumentTypeSvg,
                      // title: 'Utility File: ${context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.utilityBillFileName}',
                      title: 'Utility File: Image',
                      imagePath: context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.utilityBillPath.isEmpty
                          ? AppAssets.carouselPlaceholderPng
                          : AppUrl.fileBaseUrl + context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.utilityBillPath),
                ],
              ),
            ),
          ),
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

  Widget _detailPictureItem({required BuildContext context, required String icon, required String title, required String imagePath, Function()? onTap}) {
    bool isEmptyImg = imagePath.isEmpty || imagePath == 'assets/images/carousel_placeholder.jpg';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 12.w),
        Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyText2)),
        SizedBox(width: 10.w),
        Expanded(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover),
              ),
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, 6.5.h),
                child: TextButton(
                  onPressed: () {
                    if (isEmptyImg) {
                      return;
                    }
                    heroImage = imagePath;
                    // go the big image screen
                    context.read<ProfileViewModel>().moveToHeroImage();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black38,
                    minimumSize: Size(double.infinity, 30.h),
                  ),
                  child: Text(
                    'View Doc',
                    style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
