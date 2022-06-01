import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/manager/forgot_password_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';

class ResetPasswordPageContent extends StatefulWidget {
  const ResetPasswordPageContent({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageContentState createState() => _ResetPasswordPageContentState();
}

class _ResetPasswordPageContentState extends State<ResetPasswordPageContent> {
  @override
  void initState() {
    context.read<ForgotPasswordViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Forgot Password', showBackButton: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 56.h, width: double.infinity),
          Align(
            alignment: Alignment.center,
            child: Text('Reset Password', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
          ),
          SizedBox(height: 22.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(22.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<ForgotPasswordViewModel>().restForgotPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Text(
                        'Create New Password',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 26.h),
                      ValueListenableBuilder<bool>(
                        valueListenable: context.read<ForgotPasswordViewModel>().newPasswordObsecure,
                        builder: (_, obsecureText, __) {
                          return CustomTextFormField(
                            interactiveSelection: false,
                            maxLines: 1,
                            obscureText: obsecureText,
                            prefixIconPath: AppAssets.icLockSvg,
                            suffixIconPath: obsecureText ? AppAssets.icEyeClosedSvg : AppAssets.icEyeOpenSvg,
                            labelText: context.read<ForgotPasswordViewModel>().newPasswordLabelText,
                            hintText: context.read<ForgotPasswordViewModel>().newPasswordHintText,
                            controller: context.read<ForgotPasswordViewModel>().newPasswordController,
                            focusNode: context.read<ForgotPasswordViewModel>().newPasswordFocusNode,
                            onFieldSubmitted: (_) => context.read<ForgotPasswordViewModel>().onNewPasswordSubmitted(context),
                            suffixIconOnTap: context.read<ForgotPasswordViewModel>().onNewObsecureChange,
                            validator: context.read<ForgotPasswordViewModel>().validateNewPassword,
                            onChanged: context.read<ForgotPasswordViewModel>().onNewPasswordChange,
                          );
                        },
                      ),
                      SizedBox(height: 5.h),
                      MultiValueListenableBuilder(
                        valueListenables: [
                          context.read<ForgotPasswordViewModel>().isPasswordStrengthVisible,
                          context.read<ForgotPasswordViewModel>().passwordStrengthStr,
                          context.read<ForgotPasswordViewModel>().passwordStrengthColor,
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
                        valueListenable: context.read<ForgotPasswordViewModel>().confirmPasswordObsecure,
                        builder: (_, obsecureText, __) {
                          return CustomTextFormField(
                            interactiveSelection: false,
                            maxLines: 1,
                            obscureText: obsecureText,
                            prefixIconPath: AppAssets.icLockSvg,
                            suffixIconPath: obsecureText ? AppAssets.icEyeClosedSvg : AppAssets.icEyeOpenSvg,
                            labelText: context.read<ForgotPasswordViewModel>().confirmPasswordLabelText,
                            hintText: context.read<ForgotPasswordViewModel>().confirmPasswordHintText,
                            controller: context.read<ForgotPasswordViewModel>().confirmPasswordController,
                            focusNode: context.read<ForgotPasswordViewModel>().confirmPasswordFocusNode,
                            onFieldSubmitted: (_) => context.read<ForgotPasswordViewModel>().onConfirmPasswordSubmitted(context),
                            suffixIconOnTap: context.read<ForgotPasswordViewModel>().onConfirmObsecureChange,
                            validator: context.read<ForgotPasswordViewModel>().validateConfirmPassword,
                            onChanged: context.read<ForgotPasswordViewModel>().onConfirmPasswordChange,
                          );
                        },
                      ),
                      SizedBox(height: 26.h),
                      ContinueButton(
                        text: 'Confirm',
                        loadingNotifier: context.read<ForgotPasswordViewModel>().isResetPasswordLoadingNotifier,
                        onPressed: () async {
                          context.read<ForgotPasswordViewModel>().isConfirmButtonPressed = true;
                          if (!context.read<ForgotPasswordViewModel>().restForgotPasswordFormKey.currentState!.validate()) {
                            return;
                          }
                          context.read<ForgotPasswordViewModel>().resetPassword(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
