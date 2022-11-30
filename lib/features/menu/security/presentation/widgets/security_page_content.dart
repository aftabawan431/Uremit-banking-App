import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/change_password_bottom_sheet.dart';
import 'package:uremit/features/menu/security/presentation/manager/security_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../account_wrapper/presentation/manager/account_wrapper_view_model.dart';

class SecurityPageContent extends StatefulWidget {
  const SecurityPageContent({Key? key}) : super(key: key);

  @override
  _SecurityPageContentState createState() => _SecurityPageContentState();
}

class _SecurityPageContentState extends State<SecurityPageContent> {
  @override
  void initState() {
    context.read<SecurityViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
        child: Form(
          key: context.read<SecurityViewModel>().securityFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change Your Password', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 16.h),
                ValueListenableBuilder<bool>(
                  valueListenable: context.read<SecurityViewModel>().newPasswordObsecure,
                  builder: (_, obsecureText, __) {
                    return CustomTextFormField(
                      interactiveSelection: false,
                      maxLines: 1,
                      obscureText: obsecureText,
                      prefixIconPath: AppAssets.icPasswordSvg,
                      suffixIconPath: obsecureText ? AppAssets.icEyeClosedSvg : AppAssets.icEyeOpenSvg,
                      labelText: context.read<SecurityViewModel>().newPasswordLabelText,
                      hintText: context.read<SecurityViewModel>().newPasswordHintText,
                      controller: context.read<SecurityViewModel>().newPasswordController,
                      focusNode: context.read<SecurityViewModel>().newPasswordFocusNode,
                      onFieldSubmitted: (_) => context.read<SecurityViewModel>().onNewPasswordSubmitted(context),
                      suffixIconOnTap: context.read<SecurityViewModel>().onNewObsecureChange,
                      validator: context.read<SecurityViewModel>().validateNewPassword,
                      onChanged: context.read<SecurityViewModel>().onNewPasswordChange,
                    );
                  },
                ),
                SizedBox(height: 5.h),
                MultiValueListenableBuilder(
                  valueListenables: [
                    context.read<SecurityViewModel>().isPasswordStrengthVisible,
                    context.read<SecurityViewModel>().passwordStrengthStr,
                    context.read<SecurityViewModel>().passwordStrengthColor,
                  ],
                  builder: (_, value, __) {
                    return Visibility(
                      visible: value.elementAt(0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(value.elementAt(1), style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w500, color: value.elementAt(2))),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                ValueListenableBuilder<bool>(
                  valueListenable: context.read<SecurityViewModel>().confirmPasswordObsecure,
                  builder: (_, obsecureText, __) {
                    return CustomTextFormField(
                      interactiveSelection: false,
                      maxLines: 1,
                      obscureText: obsecureText,
                      prefixIconPath: AppAssets.icPasswordSvg,
                      suffixIconPath: obsecureText ? AppAssets.icEyeClosedSvg : AppAssets.icEyeOpenSvg,
                      labelText: context.read<SecurityViewModel>().confirmPasswordLabelText,
                      hintText: context.read<SecurityViewModel>().confirmPasswordHintText,
                      controller: context.read<SecurityViewModel>().confirmPasswordController,
                      focusNode: context.read<SecurityViewModel>().confirmPasswordFocusNode,
                      onFieldSubmitted: (_) => context.read<SecurityViewModel>().onConfirmPasswordSubmitted(context),
                      suffixIconOnTap: context.read<SecurityViewModel>().onConfirmObsecureChange,
                      validator: context.read<SecurityViewModel>().validateConfirmPassword,
                      onChanged: context.read<SecurityViewModel>().onConfirmPasswordChange,
                    );
                  },
                ),
                SizedBox(height: 44.h),
                ContinueButton(
                  text: 'Update',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    context.read<SecurityViewModel>().isUpdateButtonPressed = true;
                    if (!context.read<SecurityViewModel>().securityFormKey.currentState!.validate()) {
                      return;
                    }
                    ChangePasswordBottomSheet _bottomSheet = ChangePasswordBottomSheet(context: context);
                    await _bottomSheet.show();
                  },
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    AccountWrapperViewModel provider = sl();
                    provider.bottomNavigationKey.currentState!.setPage(0);
                  },
                  child: Text('Cancel', style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
