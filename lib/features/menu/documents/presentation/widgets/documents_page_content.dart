import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/menu/documents/presentation/manager/documents_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/providers/date_time_provider.dart';
import '../../../../../app/widgets/bottom_sheets/date_time_bottom_sheet.dart';
import '../../../../../app/widgets/bottom_sheets/docment_required_document_type_bottom_sheet.dart';
import '../../../../../app/widgets/bottom_sheets/document_required_issuing_country_bottom_sheet.dart';
import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../utils/constants/enums/attachment_type.dart';
import '../../../../../utils/globals/app_globals.dart';

class DocumentsPageContent extends StatefulWidget {
  const DocumentsPageContent({Key? key}) : super(key: key);

  @override
  _DocumentsPageContentState createState() => _DocumentsPageContentState();
}

class _DocumentsPageContentState extends State<DocumentsPageContent> {
  @override
  void initState() {
    context.read<DocumentsViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
        child: Form(
          key: context.read<DocumentsViewModel>().documentFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Document', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  enabled: false,
                  maxLines: 1,
                  // readOnly: true,
                  prefixIconPath: AppAssets.icDocumentTypeSvg,
                  keyboardType: TextInputType.name,
                  labelText: context.read<DocumentsViewModel>().documentTypeLabelText,
                  hintText: context.read<DocumentsViewModel>().documentTypeHintText,
                  controller: context.read<DocumentsViewModel>().documentTypeController,
                  focusNode: context.read<DocumentsViewModel>().documentTypeFocusNode,
                  validator: context.read<DocumentsViewModel>().validateDocumentType,
                  onChanged: context.read<DocumentsViewModel>().onDocumentTypeChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onDocumentTypeSubmitted(context),
                  suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                  onTap: () async {
                    DocRequiredDocTypeBottomSheet _bottomSheet = DocRequiredDocTypeBottomSheet(context);
                    context.read<DocumentsViewModel>().getDocTypes();
                    await _bottomSheet.show();
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  maxLines: 1,
                  prefixIconPath: AppAssets.icRemarksSvg,
                  keyboardType: TextInputType.text,
                  labelText: context.read<DocumentsViewModel>().documentRemarksLabelText,
                  hintText: context.read<DocumentsViewModel>().documentRemarksHintText,
                  controller: context.read<DocumentsViewModel>().documentRemarksController,
                  focusNode: context.read<DocumentsViewModel>().documentRemarksFocusNode,
                  validator: context.read<DocumentsViewModel>().validateDocumentRemarks,
                  onChanged: context.read<DocumentsViewModel>().onDocumentRemarksChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onDocumentNumberSubmitted(context),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  maxLines: 1,
                  readOnly: true,
                  suffixIconPath: AppAssets.icCameraSvg,
                  prefixIconPath: AppAssets.icDocumentTypeSvg,
                  keyboardType: TextInputType.name,
                  labelText: context.read<DocumentsViewModel>().frontSideLabelText,
                  hintText: context.read<DocumentsViewModel>().frontSideHintText,
                  controller: context.read<DocumentsViewModel>().frontSideController,
                  focusNode: context.read<DocumentsViewModel>().frontSideFocusNode,
                  validator: context.read<DocumentsViewModel>().validateFrontSide,
                  onChanged: context.read<DocumentsViewModel>().onFrontSideChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onFrontSideSubmitted(context),
                  onTap: () async {
                    await context.read<DocumentsViewModel>().personalDetailsImageSelector(context, AttachmentType.frontSide);
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  maxLines: 1,
                  readOnly: false,
                  suffixIconPath: AppAssets.icCameraSvg,
                  prefixIconPath: AppAssets.icDocumentTypeSvg,
                  keyboardType: TextInputType.name,
                  labelText: context.read<DocumentsViewModel>().backSideLabelText,
                  hintText: context.read<DocumentsViewModel>().backSideHintText,
                  controller: context.read<DocumentsViewModel>().backSideController,
                  focusNode: context.read<DocumentsViewModel>().backSideFocusNode,
                  validator: context.read<DocumentsViewModel>().validateBackSide,
                  onChanged: context.read<DocumentsViewModel>().onBackSideChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onBackSideSubmitted(context),
                  onTap: () async {
                    await context.read<DocumentsViewModel>().personalDetailsImageSelector(context, AttachmentType.backSide);
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  maxLines: 1,
                  readOnly: true,
                  prefixIconPath: AppAssets.icCalendarSvg,
                  keyboardType: TextInputType.datetime,
                  labelText: context.read<DocumentsViewModel>().expiryLabelText,
                  hintText: context.read<DocumentsViewModel>().expiryHintText,
                  controller: context.read<DocumentsViewModel>().expiryController,
                  focusNode: context.read<DocumentsViewModel>().expiryFocusNode,
                  validator: context.read<DocumentsViewModel>().validateExpiryDate,
                  onChanged: context.read<DocumentsViewModel>().onExpiryDateChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onExpiryDateSubmitted(context),
                  suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                  onTap: () async {
                    final selectDateTimeBottomSheet = DateTimeBottomSheet(context: context, initialSelectedDate: context.read<DocumentsViewModel>().expiryDateTime, isDob: false);
                    await selectDateTimeBottomSheet.show();
                    if (context.read<DateTimeProvider>().updateExpiryDate.value != null) {
                      context.read<DocumentsViewModel>().expiryController.text = DateFormat('yyyy-MM-dd').format(context.read<DateTimeProvider>().updateExpiryDate.value!);
                    }
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  maxLines: 1,
                  prefixIconPath: AppAssets.icAuthoritySvg,
                  keyboardType: TextInputType.name,
                  labelText: context.read<DocumentsViewModel>().issuingAuthorityLabelText,
                  hintText: context.read<DocumentsViewModel>().issuingAuthorityHintText,
                  controller: context.read<DocumentsViewModel>().issuingAuthorityController,
                  focusNode: context.read<DocumentsViewModel>().issuingAuthorityFocusNode,
                  validator: context.read<DocumentsViewModel>().validateIssuingAuthority,
                  onChanged: context.read<DocumentsViewModel>().onIssuingAuthorityChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onIssuingAuthoritySubmitted(context),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  maxLines: 1,
                  readOnly: true,
                  prefixIconPath: AppAssets.icCountrySvg,
                  keyboardType: TextInputType.name,
                  labelText: context.read<DocumentsViewModel>().issuingCountryLabelText,
                  hintText: context.read<DocumentsViewModel>().issuingCountryHintText,
                  controller: context.read<DocumentsViewModel>().issuingCountryController,
                  focusNode: context.read<DocumentsViewModel>().issuingCountryFocusNode,
                  validator: context.read<DocumentsViewModel>().validateIssuingCountry,
                  onChanged: context.read<DocumentsViewModel>().onIssuingCountryChange,
                  onFieldSubmitted: (_) => context.read<DocumentsViewModel>().onIssuingCountrySubmitted(context),
                  suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                  onTap: () async {
                    DocRequiredCountriesBottomSheet bottomSheet = DocRequiredCountriesBottomSheet(context: context, type: 0);
                    context.read<DocumentsViewModel>().getCountries();
                    await bottomSheet.show();
                  },
                ),
                SizedBox(height: 26.h),
                ContinueButton(
                  text: 'Save',
                  loadingNotifier: context.read<DocumentsViewModel>().isDocsLoadingNotifier,
                  onPressed: () async {
                    context.read<DocumentsViewModel>().isSaveButtonPressed = true;
                    if (!context.read<DocumentsViewModel>().documentFormKey.currentState!.validate() &&
                        requiredDocId.isEmpty &&
                        requiredDocId == null &&
                        requiredDocAttachmentId == null &&
                        requiredDocAttachmentId.isEmpty) {
                      return;
                    }
                    await context.read<DocumentsViewModel>().documentRequired(context);
                    // context.read<DocumentsViewModel>().clearFields();
                    // context.read<RequiredFilesViewModel>().isLoadingNotifier.value = true;
                  },
                ),
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: context.read<DocumentsViewModel>().moveToFilesWrapperPage,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('View Files', style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor)),
                          SizedBox(width: 8.w),
                          const Icon(Icons.east_rounded),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(flex: 2),
                        Expanded(
                          child: Divider(thickness: 2.h, color: Theme.of(context).primaryColor, height: 3.h),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
