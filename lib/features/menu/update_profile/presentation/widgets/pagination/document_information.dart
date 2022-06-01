import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/doc_type_bottom_sheet.dart';
import 'package:uremit/utils/constants/enums/attachment_type.dart';

import '../../../../../../app/providers/date_time_provider.dart';
import '../../../../../../app/widgets/bottom_sheets/countries_bottom_sheet.dart';
import '../../../../../../app/widgets/bottom_sheets/date_time_bottom_sheet.dart';
import '../../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../../../../home/presentation/manager/home_view_model.dart';
import '../../../../profile/presentation/manager/profile_view_model.dart';
import '../../manager/update_profile_view_model.dart';

class DocumentInformation extends StatelessWidget {
  const DocumentInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<UpdateProfileViewModel>().documentFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Document Information', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icDocumentTypeSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().documentTypeLabelText,
              hintText: context.read<UpdateProfileViewModel>().documentTypeHintText,
              controller: context.read<UpdateProfileViewModel>().documentTypeController,
              focusNode: context.read<UpdateProfileViewModel>().documentTypeFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateDocumentType,
              onChanged: context.read<UpdateProfileViewModel>().onDocumentTypeChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onDocumentTypeSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                DocTypeBottomSheet _bottomSheet = DocTypeBottomSheet(context);
                context.read<UpdateProfileViewModel>().getDocTypes();
                await _bottomSheet.show();
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              prefixIconPath: AppAssets.icDocumentNumberSvg,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              labelText: context.read<UpdateProfileViewModel>().documentNumberLabelText,
              hintText: context.read<UpdateProfileViewModel>().documentNumberHintText,
              controller: context.read<UpdateProfileViewModel>().documentNumberController,
              focusNode: context.read<UpdateProfileViewModel>().documentNumberFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateDocumentNumber,
              onChanged: context.read<UpdateProfileViewModel>().onDocumentNumberChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onDocumentNumberSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              suffixIconPath: AppAssets.icCameraSvg,
              prefixIconPath: AppAssets.icDocumentTypeSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().frontSideLabelText,
              hintText: context.read<UpdateProfileViewModel>().frontSideHintText,
              controller: context.read<UpdateProfileViewModel>().frontSideController,
              focusNode: context.read<UpdateProfileViewModel>().frontSideFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateFrontSide,
              onChanged: context.read<UpdateProfileViewModel>().onFrontSideChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onFrontSideSubmitted(context),
              onTap: () async {
                await context.read<UpdateProfileViewModel>().docsImageSelector(context, AttachmentType.frontSide);
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              suffixIconPath: AppAssets.icCameraSvg,
              prefixIconPath: AppAssets.icDocumentTypeSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().backSideLabelText,
              hintText: context.read<UpdateProfileViewModel>().backSideHintText,
              controller: context.read<UpdateProfileViewModel>().backSideController,
              focusNode: context.read<UpdateProfileViewModel>().backSideFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateBackSide,
              onChanged: context.read<UpdateProfileViewModel>().onBackSideChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onBackSideSubmitted(context),
              onTap: () async {
                await context.read<UpdateProfileViewModel>().docsImageSelector(context, AttachmentType.backSide);
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCalendarSvg,
              keyboardType: TextInputType.datetime,
              labelText: context.read<UpdateProfileViewModel>().expiryLabelText,
              hintText: context.read<UpdateProfileViewModel>().expiryHintText,
              controller: context.read<UpdateProfileViewModel>().expiryController,
              focusNode: context.read<UpdateProfileViewModel>().expiryFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateExpiryDate,
              onChanged: context.read<UpdateProfileViewModel>().onExpiryDateChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onExpiryDateSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                final selectDateTimeBottomSheet = DateTimeBottomSheet(
                    context: context,
                    initialSelectedDate: context.read<UpdateProfileViewModel>().expiryDateTime,
                    isDob: false,
                    maxDate: DateTime.now().add(const Duration(days: 2000)));
                await selectDateTimeBottomSheet.show();
                if (context.read<DateTimeProvider>().updateExpiryDate.value != null) {
                  context.read<UpdateProfileViewModel>().expiryController.text = DateFormat('yyyy-MM-dd').format(context.read<DateTimeProvider>().updateExpiryDate.value!);
                }
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icAuthoritySvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().issuingAuthorityLabelText,
              hintText: context.read<UpdateProfileViewModel>().issuingAuthorityHintText,
              controller: context.read<UpdateProfileViewModel>().issuingAuthorityController,
              focusNode: context.read<UpdateProfileViewModel>().issuingAuthorityFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateIssuingAuthority,
              onChanged: context.read<UpdateProfileViewModel>().onIssuingAuthorityChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onIssuingAuthoritySubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCountrySvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().issuingCountryLabelText,
              hintText: context.read<UpdateProfileViewModel>().issuingCountryHintText,
              controller: context.read<UpdateProfileViewModel>().issuingCountryController,
              focusNode: context.read<UpdateProfileViewModel>().issuingCountryFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateIssuingCountry,
              onChanged: context.read<UpdateProfileViewModel>().onIssuingCountryChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onIssuingCountrySubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                CountriesBottomSheet bottomSheet = CountriesBottomSheet(context: context, type: 2);
                context.read<UpdateProfileViewModel>().getCountries();
                await bottomSheet.show();
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              suffixIconPath: AppAssets.icCameraSvg,
              prefixIconPath: AppAssets.icDocumentTypeSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().utilityLabelText,
              hintText: context.read<UpdateProfileViewModel>().utilityHintText,
              controller: context.read<UpdateProfileViewModel>().utilityController,
              focusNode: context.read<UpdateProfileViewModel>().utilityFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateUtility,
              onChanged: context.read<UpdateProfileViewModel>().onUtilityChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onUtilitySubmitted(context),
              onTap: () async {
                await context.read<UpdateProfileViewModel>().docsImageSelector(context, AttachmentType.utilityBill);
              },
            ),
            SizedBox(height: 16.h),
            ContinueButton(
              text: 'Update',
              loadingNotifier: context.read<UpdateProfileViewModel>().isUpdateNotifier,
              onPressed: () async {
                context.read<UpdateProfileViewModel>().isUpdateButtonPressed = true;
                if (!context.read<UpdateProfileViewModel>().documentFormKey.currentState!.validate() &&
                    !context.read<UpdateProfileViewModel>().personalFormKey.currentState!.validate() &&
                    !context.read<UpdateProfileViewModel>().addressFormKey.currentState!.validate()) {
                  return;
                }
                await context.read<UpdateProfileViewModel>().updateProfileData(context);

                context.read<ProfileViewModel>().isLoadingNotifier.value = true;

                await context.read<ProfileViewModel>().getProfile(recall: true);

                await context.read<HomeViewModel>().getProfileHeader(recall: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
