import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/app/widgets/customs/custom_form_field.dart';
import 'package:uremit/features/authentication/registration/presentation/manager/registration_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';

class RegistrationPageContent extends StatefulWidget {
  const RegistrationPageContent({Key? key}) : super(key: key);

  @override
  _RegistrationPageContentState createState() =>
      _RegistrationPageContentState();
}

class _RegistrationPageContentState extends State<RegistrationPageContent> {
  @override
  void initState() {
    context.read<RegistrationViewModel>().onErrorMessage = (value) => context
        .show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
    context.read<RegistrationViewModel>().resetFields();
    context.read<RegistrationViewModel>().isLoadingNotifier.value=false;
  }

  @override
  Widget build(BuildContext context) {
    print('Registration Building');
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: context.read<RegistrationViewModel>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to Uremit',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 34.h),
                CustomTextFormField(
                  interactiveSelection: false,
                  maxLines: 1,
                  prefixIconPath: AppAssets.icEmailSvg,
                  keyboardType: TextInputType.emailAddress,
                  labelText:
                      context.read<RegistrationViewModel>().emailLabelText,
                  hintText: context.read<RegistrationViewModel>().emailHintText,
                  controller:
                      context.read<RegistrationViewModel>().emailController,
                  focusNode:
                      context.read<RegistrationViewModel>().emailFocusNode,
                  validator:
                      context.read<RegistrationViewModel>().validateEmail,
                  onChanged:
                      context.read<RegistrationViewModel>().onEmailChange,
                  onFieldSubmitted: (_) => context
                      .read<RegistrationViewModel>()
                      .onEmailSubmitted(context),
                ),
                SizedBox(height: 22.h),
                ValueListenableBuilder<bool>(
                  valueListenable: context
                      .read<RegistrationViewModel>()
                      .obsecureTextNotifier,
                  builder: (_, obsecureText, __) {
                    return CustomTextFormField(
                      interactiveSelection: false,
                      maxLines: 1,
                      obscureText: obsecureText,
                      prefixIconPath: AppAssets.icLockSvg,
                      suffixIconPath: obsecureText
                          ? AppAssets.icEyeClosedSvg
                          : AppAssets.icEyeOpenSvg,
                      labelText: context
                          .read<RegistrationViewModel>()
                          .passwordLabelText,
                      hintText: context
                          .read<RegistrationViewModel>()
                          .passwordHintText,
                      controller: context
                          .read<RegistrationViewModel>()
                          .passwordController,
                      focusNode: context
                          .read<RegistrationViewModel>()
                          .passwordFocusNode,
                      onFieldSubmitted: (_) => context
                          .read<RegistrationViewModel>()
                          .onPasswordSubmitted(context),
                      suffixIconOnTap: context
                          .read<RegistrationViewModel>()
                          .onObsecureChange,
                      validator: context
                          .read<RegistrationViewModel>()
                          .validatePassword,
                      onChanged: context
                          .read<RegistrationViewModel>()
                          .onPasswordChange,
                    );
                  },
                ),
                SizedBox(height: 5.h),
                MultiValueListenableBuilder(
                  valueListenables: [
                    context
                        .read<RegistrationViewModel>()
                        .isPasswordStrengthVisible,
                    context.read<RegistrationViewModel>().passwordStrengthStr,
                    context.read<RegistrationViewModel>().passwordStrengthColor,
                  ],
                  builder: (_, value, __) {
                    return Visibility(
                      visible: value.elementAt(0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(value.elementAt(1),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: value.elementAt(2))),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                ValueListenableBuilder<String?>(
                    valueListenable: context
                        .read<RegistrationViewModel>()
                        .selectedPhoneNumber,
                    builder: (_, value, __) {
                      return CustomTextFormField(
                        interactiveSelection: false,
                        maxLines: 1,
                        maxLengthEnforced: true,
                        maxLength: 13,
                        // prefix: GestureDetector(
                        //     onTap: (){
                        //       print('hello');
                        //     },
                        //     child: SvgPicture.asset(AppAssets.icPhoneSvg)),
                        customPrefix: value == null
                            ? GestureDetector(
                                onTap: _onTap,
                                child: SvgPicture.asset(AppAssets.icPhoneSvg))
                            : GestureDetector(
                                onTap: _onTap, child: Row(
                          mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(value),
                                     Icon(Icons.keyboard_arrow_down_rounded,color: Theme.of(context).primaryColor,)
                                  ],
                                )),

                        keyboardType: TextInputType.phone,
                        labelText: context
                            .read<RegistrationViewModel>()
                            .phoneLabelText,
                        hintText:
                            context.read<RegistrationViewModel>().phoneHintText,
                        controller: context
                            .read<RegistrationViewModel>()
                            .phoneController,
                        focusNode: context
                            .read<RegistrationViewModel>()
                            .phoneFocusNode,
                        // inputFormatters: [
                        //   MaskTextInputFormatter(mask: '####-#######', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy),
                        // ],
                        onFieldSubmitted: (_) => context
                            .read<RegistrationViewModel>()
                            .onPhoneSubmitted(context),
                        validator:
                            context.read<RegistrationViewModel>().validatePhone,
                        onChanged:
                            context.read<RegistrationViewModel>().onPhoneChange,
                      );
                    }),
                SizedBox(height: 10.h),
                Visibility(
                  visible: false,
                  child: Transform.translate(
                    offset: Offset(-12.w, 0),
                    child: Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: context
                              .read<RegistrationViewModel>()
                              .referralCodeCheckNotifier,
                          builder: (_, bool value, __) => Checkbox(
                            value: value,
                            onChanged: context
                                .read<RegistrationViewModel>()
                                .referralCheckChange,
                          ),
                        ),
                        Text(
                          'Do you have a referral code?',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Transform.translate(
                    offset: Offset(-12.w, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: context
                              .read<RegistrationViewModel>()
                              .promotionalCheckNotifier,
                          builder: (_, bool value, __) => Checkbox(
                            value: value,
                            onChanged: context
                                .read<RegistrationViewModel>()
                                .promotionalCheckChange,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Click to be first to find out our new services and exclusive Offers via email, sms or chat.',
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                ContinueButton(
                  text: 'Sign Up',
                  loadingNotifier:
                      context.read<RegistrationViewModel>().isLoadingNotifier,
                  onPressed: () async {
                    context.read<RegistrationViewModel>().isButtonPressed =
                        true;
                    FocusScope.of(context).unfocus();
                    if (!context
                        .read<RegistrationViewModel>()
                        .formKey
                        .currentState!
                        .validate()) {
                      return;
                    }
                    await context.read<RegistrationViewModel>().registerUser();
                  },
                ),
                // const SocialLogins(),
                SizedBox(height: 22.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      context.read<RegistrationViewModel>().selectedPhoneNumber.value =
          country.callingCode;
    }
  }
}
