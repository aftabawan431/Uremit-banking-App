import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/personal_info_countried_bottom_sheet.dart';
import 'package:uremit/utils/constants/enums/attachment_type.dart';

import '../../../../../../app/providers/date_time_provider.dart';
import '../../../../../../app/widgets/bottom_sheets/date_time_bottom_sheet.dart';
import '../../../../../../app/widgets/bottom_sheets/document_type_personal_details_bottom_sheet.dart';
import '../../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../../../../home/presentation/manager/home_view_model.dart';
import '../../../../../menu/profile/presentation/manager/profile_view_model.dart';
import '../../manager/personal_info_view_model.dart';

class PersonalInfoDocumentInformation extends StatelessWidget {
  const PersonalInfoDocumentInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<ProfileInfoViewModel>().documentFormKey,
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
              labelText: context.read<ProfileInfoViewModel>().documentTypeLabelText,
              hintText: context.read<ProfileInfoViewModel>().documentTypeHintText,
              controller: context.read<ProfileInfoViewModel>().documentTypeController,
              focusNode: context.read<ProfileInfoViewModel>().documentTypeFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateDocumentType,
              onChanged: context.read<ProfileInfoViewModel>().onDocumentTypeChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onDocumentTypeSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                DocTypePersonalInfoBottomSheet _bottomSheet = DocTypePersonalInfoBottomSheet(context);
                context.read<ProfileInfoViewModel>().getDocTypes();
                await _bottomSheet.show();
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              prefixIconPath: AppAssets.icDocumentNumberSvg,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              labelText: context.read<ProfileInfoViewModel>().documentNumberLabelText,
              hintText: context.read<ProfileInfoViewModel>().documentNumberHintText,
              controller: context.read<ProfileInfoViewModel>().documentNumberController,
              focusNode: context.read<ProfileInfoViewModel>().documentNumberFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateDocumentNumber,
              onChanged: context.read<ProfileInfoViewModel>().onDocumentNumberChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onDocumentNumberSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              suffixIconPath: AppAssets.icCameraSvg,
              prefixIconPath: AppAssets.icDocumentTypeSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<ProfileInfoViewModel>().frontSideLabelText,
              hintText: context.read<ProfileInfoViewModel>().frontSideHintText,
              controller: context.read<ProfileInfoViewModel>().frontSideController,
              focusNode: context.read<ProfileInfoViewModel>().frontSideFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateFrontSide,
              onChanged: context.read<ProfileInfoViewModel>().onFrontSideChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onFrontSideSubmitted(context),
              onTap: () async {
                await context.read<ProfileInfoViewModel>().personalDetailsImageSelector(context, AttachmentType.frontSide);
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              suffixIconPath: AppAssets.icCameraSvg,
              prefixIconPath: AppAssets.icDocumentTypeSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<ProfileInfoViewModel>().backSideLabelText,
              hintText: context.read<ProfileInfoViewModel>().backSideHintText,
              controller: context.read<ProfileInfoViewModel>().backSideController,
              focusNode: context.read<ProfileInfoViewModel>().backSideFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateBackSide,
              onChanged: context.read<ProfileInfoViewModel>().onBackSideChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onBackSideSubmitted(context),
              onTap: () async {
                await context.read<ProfileInfoViewModel>().personalDetailsImageSelector(context, AttachmentType.backSide);
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCalendarSvg,
              keyboardType: TextInputType.datetime,
              labelText: context.read<ProfileInfoViewModel>().expiryLabelText,
              hintText: context.read<ProfileInfoViewModel>().expiryHintText,
              controller: context.read<ProfileInfoViewModel>().expiryController,
              focusNode: context.read<ProfileInfoViewModel>().expiryFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateExpiryDate,
              onChanged: context.read<ProfileInfoViewModel>().onExpiryDateChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onExpiryDateSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                final selectDateTimeBottomSheet = DateTimeBottomSheet(context: context, initialSelectedDate: context.read<ProfileInfoViewModel>().expiryDateTime, isDob: false);
                await selectDateTimeBottomSheet.show();
                if (context.read<DateTimeProvider>().updateExpiryDate.value != null) {
                  context.read<ProfileInfoViewModel>().expiryController.text = DateFormat('yyyy-MM-dd').format(context.read<DateTimeProvider>().updateExpiryDate.value!);
                }
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icAuthoritySvg,
              keyboardType: TextInputType.name,
              labelText: context.read<ProfileInfoViewModel>().issuingAuthorityLabelText,
              hintText: context.read<ProfileInfoViewModel>().issuingAuthorityHintText,
              controller: context.read<ProfileInfoViewModel>().issuingAuthorityController,
              focusNode: context.read<ProfileInfoViewModel>().issuingAuthorityFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateIssuingAuthority,
              onChanged: context.read<ProfileInfoViewModel>().onIssuingAuthorityChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onIssuingAuthoritySubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCountrySvg,
              keyboardType: TextInputType.name,
              labelText: context.read<ProfileInfoViewModel>().issuingCountryLabelText,
              hintText: context.read<ProfileInfoViewModel>().issuingCountryHintText,
              controller: context.read<ProfileInfoViewModel>().issuingCountryController,
              focusNode: context.read<ProfileInfoViewModel>().issuingCountryFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateIssuingCountry,
              onChanged: context.read<ProfileInfoViewModel>().onIssuingCountryChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onIssuingCountrySubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                PersonalInfoCountriesBottomSheet bottomSheet = PersonalInfoCountriesBottomSheet(context: context, type: 2);
                context.read<ProfileInfoViewModel>().getCountries();
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
              labelText: context.read<ProfileInfoViewModel>().utilityLabelText,
              hintText: context.read<ProfileInfoViewModel>().utilityHintText,
              controller: context.read<ProfileInfoViewModel>().utilityController,
              focusNode: context.read<ProfileInfoViewModel>().utilityFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateUtility,
              onChanged: context.read<ProfileInfoViewModel>().onUtilityChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onUtilitySubmitted(context),
              onTap: () async {
                await context.read<ProfileInfoViewModel>().personalDetailsImageSelector(context, AttachmentType.utilityBill);
              },
            ),
            SizedBox(height: 16.h),
            ContinueButton(
              text: 'Save',
              loadingNotifier: context.read<ProfileInfoViewModel>().saveNotifier,
              onPressed: () async {
                context.read<ProfileInfoViewModel>().isDocumentPageButtonPressed = false;
                if (!context.read<ProfileInfoViewModel>().documentFormKey.currentState!.validate()) {
                  return;
                }

                // context.read<ProfileInfoViewModel>().goBackToReceiverInfo();
                await context.read<ProfileInfoViewModel>().saveProfileData(context);

                context.read<HomeViewModel>().isLoadingNotifier.value = true;

                await context.read<ProfileViewModel>().getProfile(recall: true,reLoadData: true);

                await context.read<HomeViewModel>().getProfileHeader(recall: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
