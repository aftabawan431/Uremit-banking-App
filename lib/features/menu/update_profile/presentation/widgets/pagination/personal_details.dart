import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:uremit/app/providers/date_time_provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/date_time_bottom_sheet.dart';
import 'package:uremit/features/menu/update_profile/presentation/manager/update_profile_view_model.dart';

import '../../../../../../app/widgets/bottom_sheets/countries_bottom_sheet.dart';
import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../../utils/globals/app_globals.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> with AutomaticKeepAliveClientMixin {
  @override
  // void initState() {
  //   super.initState();
  //   context.read<UpdateProfileViewModel>().loadProfileData;
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<UpdateProfileViewModel>().personalFormKey,
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
              labelText: context.read<UpdateProfileViewModel>().firstNameLabelText,
              hintText: context.read<UpdateProfileViewModel>().firstNameHintText,
              controller: context.read<UpdateProfileViewModel>().firstNameController,
              focusNode: context.read<UpdateProfileViewModel>().firstNameFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateFirstName,
              onChanged: context.read<UpdateProfileViewModel>().onFirstNameChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onFirstNameSubmitted(context),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: context.read<UpdateProfileViewModel>().middleNameNotifier,
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
                              labelText: context.read<UpdateProfileViewModel>().middleNameLabelText,
                              hintText: context.read<UpdateProfileViewModel>().middleNameHintText,
                              controller: context.read<UpdateProfileViewModel>().middleNameController,
                              focusNode: context.read<UpdateProfileViewModel>().middleNameFocusNode,
                              validator: context.read<UpdateProfileViewModel>().validateMiddleName,
                              onChanged: context.read<UpdateProfileViewModel>().onMiddleNameChange,
                              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onMiddleNameSubmitted(context),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: context.read<UpdateProfileViewModel>().middleNameNotifier,
              builder: (_, value, __) {
                return CheckboxListTile(
                  value: value,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Receiver don\'t have a middle name', style: Theme.of(context).textTheme.caption),
                  onChanged: context.read<UpdateProfileViewModel>().onMiddleCheckboxClicked,
                );
              },
            ),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icNameSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().lastNameLabelText,
              hintText: context.read<UpdateProfileViewModel>().lastNameHintText,
              controller: context.read<UpdateProfileViewModel>().lastNameController,
              focusNode: context.read<UpdateProfileViewModel>().lastNameFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateLastName,
              onChanged: context.read<UpdateProfileViewModel>().onLastNameChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onLastNameSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCountrySvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<UpdateProfileViewModel>().cobLabelText,
              hintText: context.read<UpdateProfileViewModel>().cobHintText,
              controller: context.read<UpdateProfileViewModel>().cobController,
              focusNode: context.read<UpdateProfileViewModel>().cobFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateCob,
              onChanged: context.read<UpdateProfileViewModel>().onCobChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onOccupationSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                CountriesBottomSheet bottomSheet = CountriesBottomSheet(context: context, type: 0);
                context.read<UpdateProfileViewModel>().getCountries();
                await bottomSheet.show();
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
              maxLines: 1,
              prefixIconPath: AppAssets.icOccupationSvg,
              keyboardType: TextInputType.name,
              labelText: context.read<UpdateProfileViewModel>().occupationLabelText,
              hintText: context.read<UpdateProfileViewModel>().occupationHintText,
              controller: context.read<UpdateProfileViewModel>().occupationController,
              focusNode: context.read<UpdateProfileViewModel>().occupationFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateOccupation,
              onChanged: context.read<UpdateProfileViewModel>().onOccupationChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onOccupationSubmitted(context),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icNationalitySvg,
              keyboardType: TextInputType.streetAddress,
              labelText: context.read<UpdateProfileViewModel>().nationalityLabelText,
              hintText: context.read<UpdateProfileViewModel>().nationalityHintText,
              controller: context.read<UpdateProfileViewModel>().nationalityController,
              focusNode: context.read<UpdateProfileViewModel>().nationalityFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateNationality,
              onChanged: context.read<UpdateProfileViewModel>().onNationalityChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onNationalitySubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                CountriesBottomSheet bottomSheet = CountriesBottomSheet(context: context, type: 1);
                context.read<UpdateProfileViewModel>().getCountries();
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
                controller: context.read<UpdateProfileViewModel>().genderRadioController,
                values: context.read<UpdateProfileViewModel>().genderValues,
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
            CustomTextFormField(
              maxLines: 1,
              prefixIconPath: AppAssets.icContactSvg,
              keyboardType: TextInputType.phone,
              labelText: context.read<UpdateProfileViewModel>().phoneLabelText,
              hintText: context.read<UpdateProfileViewModel>().phoneHintText,
              controller: context.read<UpdateProfileViewModel>().phoneController,
              focusNode: context.read<UpdateProfileViewModel>().phoneFocusNode,
              // inputFormatters: [
              //   MaskTextInputFormatter(mask: '####-#######', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy),
              // ],
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onContactSubmitted(context),
              validator: context.read<UpdateProfileViewModel>().validatePhone,
              onChanged: context.read<UpdateProfileViewModel>().onPhoneChange,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              maxLines: 1,
              readOnly: true,
              prefixIconPath: AppAssets.icCalendarSvg,
              keyboardType: TextInputType.datetime,
              labelText: context.read<UpdateProfileViewModel>().dobLabelText,
              hintText: context.read<UpdateProfileViewModel>().dobHintText,
              controller: context.read<UpdateProfileViewModel>().dobController,
              focusNode: context.read<UpdateProfileViewModel>().dobFocusNode,
              validator: context.read<UpdateProfileViewModel>().validateDob,
              onChanged: context.read<UpdateProfileViewModel>().onDobChange,
              onFieldSubmitted: (_) => context.read<UpdateProfileViewModel>().onDobSubmitted(context),
              suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
              onTap: () async {
                final selectDateTimeBottomSheet = DateTimeBottomSheet(
                    context: context, initialSelectedDate: context.read<UpdateProfileViewModel>().dobDateTime.subtract(const Duration(days: 6573)), isDob: true);
                await selectDateTimeBottomSheet.show();
                print(context.read<DateTimeProvider>().dateTime.value);
                if (context.read<DateTimeProvider>().dateTime.value != null) {
                  context.read<UpdateProfileViewModel>().dobController.text = DateFormat('yyyy-MM-dd').format(context.read<DateTimeProvider>().dateTime.value!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
