import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../app/widgets/bottom_sheets/personal_info_province_bottom_sheet.dart';
import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../manager/personal_info_view_model.dart';

class PersonalAddressDetails extends StatelessWidget {
  const PersonalAddressDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<ProfileInfoViewModel>().addressFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address Detail', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icAddressSvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<ProfileInfoViewModel>().addressLabelText,
              hintText: context.read<ProfileInfoViewModel>().addressHintText,
              controller: context.read<ProfileInfoViewModel>().addressController,
              focusNode: context.read<ProfileInfoViewModel>().addressFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateAddress,
              onChanged: context.read<ProfileInfoViewModel>().onAddressChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onAddressSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icPostalCodeSvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<ProfileInfoViewModel>().postalLabelText,
              hintText: context.read<ProfileInfoViewModel>().postalHintText,
              controller: context.read<ProfileInfoViewModel>().postalController,
              focusNode: context.read<ProfileInfoViewModel>().postalFocusNode,
              validator: context.read<ProfileInfoViewModel>().validatePostalCode,
              onChanged: context.read<ProfileInfoViewModel>().onPostalCodeChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onPostalSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icCitySvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<ProfileInfoViewModel>().cityLabelText,
              hintText: context.read<ProfileInfoViewModel>().cityHintText,
              controller: context.read<ProfileInfoViewModel>().cityController,
              focusNode: context.read<ProfileInfoViewModel>().cityFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateCity,
              onChanged: context.read<ProfileInfoViewModel>().onCityChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onCitySubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icProvinceSvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<ProfileInfoViewModel>().provinceLabelText,
              hintText: context.read<ProfileInfoViewModel>().provinceHintText,
              controller: context.read<ProfileInfoViewModel>().provinceController,
              focusNode: context.read<ProfileInfoViewModel>().provinceFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateProvince,
              onChanged: context.read<ProfileInfoViewModel>().onProvinceChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onProvinceSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                PersonalInfoProvincesBottomSheet _bottomSheet =
                    PersonalInfoProvincesBottomSheet(context: context, country: context.read<ProfileInfoViewModel>().nationalityCountry!);
                _bottomSheet.show();
              },
            ),
          ],
        ),
      ),
    );
  }
}
