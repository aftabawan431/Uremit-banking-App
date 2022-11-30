import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_form_field.dart';
import 'package:uremit/features/menu/update_profile/presentation/manager/update_profile_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

import '../../../features/menu/update_profile/models/get_countries_response_model.dart';

class CountriesBottomSheet {
  final BuildContext context;
  final int type;

  CountriesBottomSheet({required this.context, required this.type});
  ValueNotifier<List<CountriesBody>> countriesList = ValueNotifier([]);


  Future show() async {
    String typeStr = '';
    switch (type) {
      case 0:
        typeStr = 'nationality';
        break;
      case 1:
        typeStr = 'birth';
        break;
      case 2:
        typeStr = 'issuing';
        break;
    }
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            height: 400.h+EdgeInsets.fromWindowPadding(
                WidgetsBinding.instance.window.viewInsets,
                WidgetsBinding
                    .instance.window.devicePixelRatio)
                .bottom,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.only(
                top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Country',
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 3.h),
                Text('Select country of $typeStr',
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context
                        .read<UpdateProfileViewModel>()
                        .isCountryLoadingNotifier,
                    builder: (_, isLoading, __) {
                      if (!isLoading && countriesList.value.isEmpty) {
                        countriesList.value = context
                            .read<UpdateProfileViewModel>()
                            .countriesList!
                            .body;
                      }

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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  CustomTextFormField(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 4),


                                    hintText: 'Search',
                                    labelText: 'Search',
                                    onChanged: (value) {
                                      countriesList.value = context
                                          .read<UpdateProfileViewModel>()
                                          .countriesList!
                                          .body
                                          .where((element) => element
                                              .countryName
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    },
                                  ),
                                  Expanded(

                                    child: ValueListenableBuilder<
                                            List<CountriesBody>>(
                                        valueListenable: countriesList,
                                        builder: (_, countriesList, __) {
                                          if(countriesList.isEmpty){
                                            return const Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Text('No country found'),
                                            );
                                          }
                                          return ListView.separated(
                                            itemCount:
                                                countriesList.length ,
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Divider(
                                                  thickness: 0.8,
                                                  color: Colors.grey
                                                      .withOpacity(0.8));
                                            },
                                            itemBuilder: (_, index) {
                                              return ListTile(
                                                contentPadding:
                                                    EdgeInsets.zero,
                                                leading: ClipOval(
                                                  child: SizedBox(
                                                    width: 40.w,
                                                    height: 40.w,
                                                    child: SvgPicture.network(
                                                      AppUrl.fileBaseUrl +
                                                          countriesList[index]
                                                              .svgPath,
                                                      width: 40.w,
                                                      height: 40.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                    countriesList[index]
                                                            .countryName ,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2),
                                                onTap: () {
                                                  if (type == 1) {
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .cobController
                                                        .text = countriesList[
                                                                index]
                                                            .countryName;
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .cobId = countriesList[
                                                                index]
                                                            .countryId;
                                                    context
                                                            .read<
                                                                UpdateProfileViewModel>()
                                                            .countryOfBirth =
                                                        countriesList[index];
                                                  } else if (type == 0) {
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .provinceController
                                                        .text = '';
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .nationalityController
                                                        .text = countriesList[
                                                                index]
                                                            .countryName;


                                                    context
                                                            .read<
                                                                UpdateProfileViewModel>()
                                                            .nationalityId =
                                                        countriesList[index]
                                                                .countryId;
                                                    context
                                                            .read<
                                                                UpdateProfileViewModel>()
                                                            .nationalityCountry =
                                                        countriesList[index];
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .getCountryProvince(countriesList[index]
                                                                .countryId);
                                                  } else if (type == 2) {
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .issuingCountryController
                                                        .text = countriesList[index]
                                                            .countryName ;
                                                    context
                                                        .read<
                                                            UpdateProfileViewModel>()
                                                        .issuingId = countriesList[index]
                                                            .countryId ;

                                                    context
                                                            .read<
                                                                UpdateProfileViewModel>()
                                                            .issuingCountry =
                                                    countriesList[index];
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                ],
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
