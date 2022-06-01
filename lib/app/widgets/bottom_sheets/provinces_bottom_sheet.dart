import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/menu/update_profile/presentation/manager/update_profile_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

import '../../../features/menu/update_profile/models/get_countries_response_model.dart';

class ProvincesBottomSheet {
  final BuildContext context;
  final CountriesBody country;

  ProvincesBottomSheet({required this.context, required this.country});

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.only(top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Province', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 3.h),
                Text('Select province from ${country.countryName}', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context.read<UpdateProfileViewModel>().isProvinceLoadingNotifier,
                    builder: (_, isLoading, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: isLoading
                            ? Center(
                                child: SizedBox(
                                  height: 40.w,
                                  width: 40.w,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: context.read<UpdateProfileViewModel>().provincesList?.provinces.length ?? 0,
                                separatorBuilder: (BuildContext context, int index) {
                                  return Divider(thickness: 0.8, color: Colors.grey.withOpacity(0.8));
                                },
                                itemBuilder: (_, index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: ClipOval(
                                      child: SizedBox(
                                        width: 40.w,
                                        height: 40.w,
                                        child: SvgPicture.network(
                                          AppUrl.fileBaseUrl + country.svgPath,
                                          width: 40.w,
                                          height: 40.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title:
                                        Text(context.read<UpdateProfileViewModel>().provincesList?.provinces[index].stateName ?? '', style: Theme.of(context).textTheme.bodyText2),
                                    subtitle: Text(country.countryName.toUpperCase(), style: Theme.of(context).textTheme.caption),
                                    onTap: () {
                                      context.read<UpdateProfileViewModel>().provinceController.text =
                                          context.read<UpdateProfileViewModel>().provincesList?.provinces[index].stateName ?? '';
                                      context.read<UpdateProfileViewModel>().provinceId = context.read<UpdateProfileViewModel>().provincesList?.provinces[index].id ?? '';

                                      context.read<UpdateProfileViewModel>().province = context.read<UpdateProfileViewModel>().provincesList?.provinces[index];
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
