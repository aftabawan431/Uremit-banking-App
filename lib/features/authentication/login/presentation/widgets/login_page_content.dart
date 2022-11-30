import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/app/widgets/customs/custom_form_field.dart';
import 'package:uremit/features/authentication/login/presentation/manager/login_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/my_app.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';

class LoginPageContent extends StatefulWidget {
  const LoginPageContent({Key? key}) : super(key: key);

  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  @override
  void initState() {
    context.read<LoginViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    Timer(const Duration(milliseconds: 500), () {
      checkIfCameFromSessionExpired();
    });
    context.read<LoginViewModel>().clearFields();

    super.initState();
  }

  checkIfCameFromSessionExpired() {
    if (isSessionExpired) {
      isSessionExpired = false;
      showModal(
          context: context,
          builder: (context) {
            return Dialog(
                child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.uremitSvg),
                  SizedBox(height: 10.h),
                  Text('Session Expired', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  Text('Please login again', style: Theme.of(context).textTheme.bodyText2)
                ],
              ),
            ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: context.read<LoginViewModel>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign in to your account', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 34.h),
                CustomTextFormField(
                  interactiveSelection: false,
                  maxLines: 1,
                  prefixIconPath: AppAssets.icEmailSvg,
                  keyboardType: TextInputType.emailAddress,
                  labelText: context.read<LoginViewModel>().emailLabelText,
                  hintText: context.read<LoginViewModel>().emailHintText,
                  controller: context.read<LoginViewModel>().emailController,
                  validator: context.read<LoginViewModel>().validateEmail,
                  focusNode: context.read<LoginViewModel>().emailFocusNode,
                  onChanged: context.read<LoginViewModel>().onEmailChange,
                  onFieldSubmitted: (_) => context.read<LoginViewModel>().onEmailSubmitted(context),
                ),
                SizedBox(height: 22.h),

                ValueListenableBuilder<bool>(
                  valueListenable: context.read<LoginViewModel>().obsecureTextNotifier,
                  builder: (_, obsecureText, __) {
                    return CustomTextFormField(
                      interactiveSelection: false,
                      maxLines: 1,
                      obscureText: obsecureText,
                      prefixIconPath: AppAssets.icLockSvg,
                      suffixIconPath: obsecureText ? AppAssets.icEyeClosedSvg : AppAssets.icEyeOpenSvg,
                      labelText: context.read<LoginViewModel>().passwordLabelText,
                      hintText: context.read<LoginViewModel>().passwordHintText,
                      controller: context.read<LoginViewModel>().passwordController,
                      focusNode: context.read<LoginViewModel>().passwordFocusNode,
                      suffixIconOnTap: context.read<LoginViewModel>().onObsecureChange,
                      onFieldSubmitted: (_) => context.read<LoginViewModel>().onPasswordSubmitted(context),
                      validator: context.read<LoginViewModel>().validatePassword,
                      onChanged: context.read<LoginViewModel>().onPasswordChange,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: context.read<LoginViewModel>().moveToGetEmailPage,
                    child: Text('Forgot Password?', style: Theme.of(context).textTheme.subtitle2),
                    style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h), primary: Colors.transparent),
                  ),
                ),
                SizedBox(height: 22.h),
                ContinueButton(
                  text: 'Login',
                  loadingNotifier: context.read<LoginViewModel>().isLoadingNotifier,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    context.read<LoginViewModel>().isButtonPressed = true;
                    if (!context.read<LoginViewModel>().formKey.currentState!.validate()) {
                      return;
                    }
                    await context.read<LoginViewModel>().login();
                  },
                ),
                // const LocalLogins(),
                // const SocialLogins(),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
