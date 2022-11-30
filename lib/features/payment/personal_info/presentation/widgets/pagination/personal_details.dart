import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:uremit/app/providers/date_time_provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/date_time_bottom_sheet.dart';
import 'package:uremit/app/widgets/bottom_sheets/personal_info_countried_bottom_sheet.dart';

import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';
import '../../manager/personal_info_view_model.dart';

class PersonalInfoDetails extends StatefulWidget {
  const PersonalInfoDetails({Key? key}) : super(key: key);

  @override
  State<PersonalInfoDetails> createState() => _PersonalInfoDetailsState();
}

class _PersonalInfoDetailsState extends State<PersonalInfoDetails> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<ProfileInfoViewModel>().personalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Detail', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icNameSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<ProfileInfoViewModel>().firstNameLabelText,
              hintText: context.read<ProfileInfoViewModel>().firstNameHintText,
              controller: context.read<ProfileInfoViewModel>().firstNameController,
              focusNode: context.read<ProfileInfoViewModel>().firstNameFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateFirstName,
              onChanged: context.read<ProfileInfoViewModel>().onFirstNameChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onFirstNameSubmitted(context),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: context.read<ProfileInfoViewModel>().middleNameNotifier,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: !value
                      ? Column(
                          children: [
                            SizedBox(height: 16.h),
                            CustomTextFormField(
                              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                              maxLines: 1,
                              prefixIconPath: AppAssets.icNameSvg,
                              keyboardType: TextInputType.name,
                              labelText: context.read<ProfileInfoViewModel>().middleNameLabelText,
                              hintText: context.read<ProfileInfoViewModel>().middleNameHintText,
                              controller: context.read<ProfileInfoViewModel>().middleNameController,
                              focusNode: context.read<ProfileInfoViewModel>().middleNameFocusNode,
                              validator: context.read<ProfileInfoViewModel>().validateMiddleName,
                              onChanged: context.read<ProfileInfoViewModel>().onMiddleNameChange,
                              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onMiddleNameSubmitted(context),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: context.read<ProfileInfoViewModel>().middleNameNotifier,
              builder: (_, value, __) {
                return CheckboxListTile(
                  value: value,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('User doesn\'t have a middle name', style: Theme.of(context).textTheme.caption),
                  onChanged: context.read<ProfileInfoViewModel>().onMiddleCheckboxClicked,
                );
              },
            ),

            ValueListenableBuilder<bool>(
              valueListenable: context.read<ProfileInfoViewModel>().lastNameNotifier,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: !value
                      ? Column(
                    children: [
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                        maxLines: 1,
                        prefixIconPath: AppAssets.icNameSvg,
                        keyboardType: TextInputType.name,
                        labelText: context.read<ProfileInfoViewModel>().lastNameLabelText,
                        hintText: context.read<ProfileInfoViewModel>().lastNameHintText,
                        controller: context.read<ProfileInfoViewModel>().lastNameController,
                        focusNode: context.read<ProfileInfoViewModel>().lastNameFocusNode,
                        validator: context.read<ProfileInfoViewModel>().validateLastName,
                        onChanged: context.read<ProfileInfoViewModel>().onLastNameChange,
                        onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onLastNameSubmitted(context),
                      )
                    ],
                  )
                      : const SizedBox.shrink(),
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: context.read<ProfileInfoViewModel>().lastNameNotifier,
              builder: (_, value, __) {
                return CheckboxListTile(
                  value: value,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('User doesn\'t have a last name', style: Theme.of(context).textTheme.caption),
                  onChanged: context.read<ProfileInfoViewModel>().onLastCheckboxClicked,
                );
              },
            ),

            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCountrySvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<ProfileInfoViewModel>().cobLabelText,
              hintText: context.read<ProfileInfoViewModel>().cobHintText,
              controller: context.read<ProfileInfoViewModel>().cobController,
              focusNode: context.read<ProfileInfoViewModel>().cobFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateCob,
              onChanged: context.read<ProfileInfoViewModel>().onCobChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onCobChange(''),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                PersonalInfoCountriesBottomSheet bottomSheet = PersonalInfoCountriesBottomSheet(context: context, type: 1);
                context.read<ProfileInfoViewModel>().getCountries();
                await bottomSheet.show();
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icOccupationSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<ProfileInfoViewModel>().occupationLabelText,
              hintText: context.read<ProfileInfoViewModel>().occupationHintText,
              controller: context.read<ProfileInfoViewModel>().occupationController,
              focusNode: context.read<ProfileInfoViewModel>().occupationFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateOccupation,
              onChanged: context.read<ProfileInfoViewModel>().onOccupationChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onOccupationSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icNationalitySvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<ProfileInfoViewModel>().nationalityLabelText,
              hintText: context.read<ProfileInfoViewModel>().nationalityHintText,
              controller: context.read<ProfileInfoViewModel>().nationalityController,
              focusNode: context.read<ProfileInfoViewModel>().nationalityFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateNationality,
              onChanged: context.read<ProfileInfoViewModel>().onNationalityChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onNationalitySubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                PersonalInfoCountriesBottomSheet bottomSheet = PersonalInfoCountriesBottomSheet(context: context, type:0);
                context.read<ProfileInfoViewModel>().getCountries();
                await bottomSheet.show();
              },
            ),
            SizedBox(height: 16.h),
            InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Gender',
                  prefix: Icon(
                    Icons.transgender,
                    color: Colors.black54,
                    size: 20,
                  )),
              child: RadioGroup(
                controller: context.read<ProfileInfoViewModel>().genderRadioController,
                values: context.read<ProfileInfoViewModel>().genderValues,
                indexOfDefault: 0,
                orientation: RadioGroupOrientation.Horizontal,
                decoration: RadioGroupDecoration(
                  spacing: 35,
                  labelStyle: Theme.of(context).textTheme.caption?.copyWith(fontSize: 9.sp),
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            ValueListenableBuilder<String?>(
                valueListenable: context
                    .read<ProfileInfoViewModel>()
                    .selectedPhoneNumber,
                builder: (_, value, __) {
                return CustomTextFormField(
                  customPrefix: value == null
                      ? GestureDetector(
                      onTap: _onTap,
                      child: SvgPicture.asset(AppAssets.icPhoneSvg))
                      : GestureDetector(
                      onTap: _onTap, child: Text(value)),
                  maxLines: 1,
                  prefixIconPath: AppAssets.icContactSvg,
                  keyboardType: TextInputType.phone,
                  labelText: context.read<ProfileInfoViewModel>().phoneLabelText,
                  hintText: context.read<ProfileInfoViewModel>().phoneHintText,
                  controller: context.read<ProfileInfoViewModel>().phoneController,
                  focusNode: context.read<ProfileInfoViewModel>().phoneFocusNode,
                  // inputFormatters: [
                  //   MaskTextInputFormatter(mask: '####-#######', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy),
                  // ],
                  onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onContactSubmitted(context),
                  validator: context.read<ProfileInfoViewModel>().validatePhone,
                  onChanged: context.read<ProfileInfoViewModel>().onPhoneChange,
                );
              }
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCalendarSvg,



              maxLengthEnforced: true,
              maxLength: 13,
              keyboardType: TextInputType.datetime,
              labelText: context.read<ProfileInfoViewModel>().dobLabelText,
              hintText: context.read<ProfileInfoViewModel>().dobHintText,
              controller: context.read<ProfileInfoViewModel>().dobController,
              focusNode: context.read<ProfileInfoViewModel>().dobFocusNode,
              validator: context.read<ProfileInfoViewModel>().validateDob,
              onChanged: context.read<ProfileInfoViewModel>().onDobChange,
              onFieldSubmitted: (_) => context.read<ProfileInfoViewModel>().onDobSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                final selectDateTimeBottomSheet =
                DateTimeBottomSheet(context: context, initialSelectedDate: context.read<ProfileInfoViewModel>().dobDateTime.subtract(const Duration(days: 6573)), isDob: true);
                await selectDateTimeBottomSheet.show();
                print(context.read<DateTimeProvider>().dateTime.value);
                if (context.read<DateTimeProvider>().dateTime.value != null) {
                  context.read<ProfileInfoViewModel>().dobController.text = DateFormat('yyyy-MM-dd').format(context.read<DateTimeProvider>().dateTime.value!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      context.read<ProfileInfoViewModel>().selectedPhoneNumber.value =
          country.callingCode;
    }
  }
  @override
  bool get wantKeepAlive => true;
}
