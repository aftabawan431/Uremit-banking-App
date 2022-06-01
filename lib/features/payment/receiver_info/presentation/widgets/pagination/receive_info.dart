import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../../app/widgets/bottom_sheets/receiver_info_country_bottom_sheet.dart';
import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../app/widgets/customs/tabview/switch_button.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../manager/receiver_info_view_model.dart';

class ReceiverInfo extends StatelessWidget {
  const ReceiverInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<ReceiverInfoViewModel>().receiverInfoFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Receiver Info', style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 16.h),
              CustomTextFormField(
                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                maxLines: 1,
                prefixIconPath: AppAssets.icNameSvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().nickNameLabelText,
                hintText: context.read<ReceiverInfoViewModel>().nickNameHintText,
                controller: context.read<ReceiverInfoViewModel>().nickNameController,
                focusNode: context.read<ReceiverInfoViewModel>().nickNameFocusNode,
                validator: context.read<ReceiverInfoViewModel>().validateNickName,
                onChanged: context.read<ReceiverInfoViewModel>().onNickNameChange,
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onNickNameSubmitted(context),
                onTap: () async {},
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                maxLines: 1,
                prefixIconPath: AppAssets.icNameSvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().firstNameLabelText,
                hintText: context.read<ReceiverInfoViewModel>().firstNameHintText,
                controller: context.read<ReceiverInfoViewModel>().firstNameController,
                focusNode: context.read<ReceiverInfoViewModel>().firstNameFocusNode,
                validator: context.read<ReceiverInfoViewModel>().validateFirstName,
                onChanged: context.read<ReceiverInfoViewModel>().onFirstNameChange,
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onFirstNameSubmitted(context),
                onTap: () async {},
              ),
              ValueListenableBuilder<bool>(
                valueListenable: context.read<ReceiverInfoViewModel>().middleNameNotifier,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: !value
                        ? Column(
                            children: [
                              SizedBox(height: 16.h),
                              CustomTextFormField(
                                maxLines: 1,
                                prefixIconPath: AppAssets.icNameSvg,
                                keyboardType: TextInputType.name,
                                labelText: context.read<ReceiverInfoViewModel>().middleNameLabelText,
                                hintText: context.read<ReceiverInfoViewModel>().middleNameHintText,
                                controller: context.read<ReceiverInfoViewModel>().middleNameController,
                                focusNode: context.read<ReceiverInfoViewModel>().middleNameFocusNode,
                                validator: context.read<ReceiverInfoViewModel>().validateMiddleName,
                                onChanged: context.read<ReceiverInfoViewModel>().onMiddleNameChange,
                                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onMiddleNameSubmitted(context),
                                onTap: () async {},
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: context.read<ReceiverInfoViewModel>().middleNameNotifier,
                builder: (_, value, __) {
                  return CheckboxListTile(
                    value: value,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Receiver don\'t have a middle name', style: Theme.of(context).textTheme.caption),
                    onChanged: context.read<ReceiverInfoViewModel>().onMiddleCheckboxClicked,
                  );
                },
              ),
              CustomTextFormField(
                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                maxLines: 1,
                prefixIconPath: AppAssets.icNameSvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().lastNameLabelText,
                hintText: context.read<ReceiverInfoViewModel>().lastNameHintText,
                controller: context.read<ReceiverInfoViewModel>().lastNameController,
                focusNode: context.read<ReceiverInfoViewModel>().lastNameFocusNode,
                validator: context.read<ReceiverInfoViewModel>().validateLastName,
                onChanged: context.read<ReceiverInfoViewModel>().onLastNameChange,
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onLastNameSubmitted(context),
                onTap: () async {},
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                maxLines: 1,
                readOnly: true,
                prefixIconPath: AppAssets.icCountrySvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().receiverCountryLabelText,
                hintText: context.read<ReceiverInfoViewModel>().receiverCountryHintText,
                controller: context.read<ReceiverInfoViewModel>().receiverCountryController,
                focusNode: context.read<ReceiverInfoViewModel>().receiverCountryFocusNode,
                suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                validator: context.read<ReceiverInfoViewModel>().validateReceiverCountry,
                onChanged: context.read<ReceiverInfoViewModel>().onReceiverCountryChange,
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onReceiverCountrySubmitted(context),
                onTap: () async {
                  ReceiverInfoCountriesBottomSheet bottomSheet = ReceiverInfoCountriesBottomSheet(context: context, type: 0);
                  context.read<ReceiverInfoViewModel>().getReceiverCountries();
                  await bottomSheet.show();
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                maxLines: 1,
                readOnly: false,
                prefixIconPath: AppAssets.icEmailSvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().receiverEmailLabelText,
                hintText: context.read<ReceiverInfoViewModel>().receiverEmailHintText,
                controller: context.read<ReceiverInfoViewModel>().receiverEmailController,
                focusNode: context.read<ReceiverInfoViewModel>().receiverEmailFocusNode,
                validator: context.read<ReceiverInfoViewModel>().validateEmail,
                onChanged: context.read<ReceiverInfoViewModel>().onEmailChange,
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onReceiverEmailSubmitted(context),
                onTap: () async {},
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                maxLines: 1,
                prefixIconPath: AppAssets.icContactSvg,
                keyboardType: TextInputType.phone,
                labelText: context.read<ReceiverInfoViewModel>().phoneLabelText,
                hintText: context.read<ReceiverInfoViewModel>().phoneHintText,
                controller: context.read<ReceiverInfoViewModel>().phoneController,
                focusNode: context.read<ReceiverInfoViewModel>().phoneFocusNode,
                // inputFormatters: [
                //   MaskTextInputFormatter(mask: '####-#######', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy),
                // ],
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onContactSubmitted(context),
                validator: context.read<ReceiverInfoViewModel>().validatePhone,
                onChanged: context.read<ReceiverInfoViewModel>().onPhoneChange,
              ),
              SizedBox(height: 16.h),
              Text('Bank Information', style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('Do you want to Add Bank A/c Transaction?',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 12,
                            )),
                  ),
                  const SwitchButton(),
                ],
              ),
              SizedBox(height: 16.h),
              if (context.read<ReceiverInfoViewModel>().status.value == false)
                ContinueButton(
                  loadingNotifier: context.read<ReceiverInfoViewModel>().isReceiverAddLoadingNotifier,
                  text: 'Proceed',
                  onPressed: () async {
                    if (context.read<ReceiverInfoViewModel>().validateReceiverInfo()) {
                      context.read<ReceiverInfoViewModel>().addReceiver(context);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
