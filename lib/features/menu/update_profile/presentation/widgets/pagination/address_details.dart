import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/provinces_bottom_sheet.dart';

import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../manager/update_profile_view_model.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<UpdateProfileViewModel>().addressFormKey,
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
              labelText: context.read<UpdateProfileViewModel>().addressLabelText,
              hintText: context.read<UpdateProfileViewModel>().addressHintText,
              controller: context.read<UpdateProfileViewModel>().addressController,
              focusNode: context.read<UpdateProfileViewModel>().addressFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateAddress,
              onChanged: context.read<UpdateProfileViewModel>().onAddressChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onAddressSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icPostalCodeSvg,
              keyboardType: TextInputType.phone,
              labelText: context.read<UpdateProfileViewModel>().postalLabelText,
              hintText: context.read<UpdateProfileViewModel>().postalHintText,
              controller: context.read<UpdateProfileViewModel>().postalController,
              focusNode: context.read<UpdateProfileViewModel>().postalFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateIssuingAuthority,
              onChanged: context.read<UpdateProfileViewModel>().onPostalCodeChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onPostalSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icCitySvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<UpdateProfileViewModel>().cityLabelText,
              hintText: context.read<UpdateProfileViewModel>().cityHintText,
              controller: context.read<UpdateProfileViewModel>().cityController,
              focusNode: context.read<UpdateProfileViewModel>().cityFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateCity,
              onChanged: context.read<UpdateProfileViewModel>().onCityChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onCitySubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icProvinceSvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<UpdateProfileViewModel>().provinceLabelText,
              hintText: context.read<UpdateProfileViewModel>().provinceHintText,
              controller: context.read<UpdateProfileViewModel>().provinceController,
              focusNode: context.read<UpdateProfileViewModel>().provinceFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateProvince,
              onChanged: context.read<UpdateProfileViewModel>().onProvinceChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onProvinceSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                ProvincesBottomSheet _bottomSheet = ProvincesBottomSheet(context: context, country: context.read<UpdateProfileViewModel>().nationalityCountry!);
                _bottomSheet.show();
              },
            ),
          ],
        ),
      ),
    );
  }
}
