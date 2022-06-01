import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/manager/forgot_password_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';

class GetEmailPageContent extends StatefulWidget {
  const GetEmailPageContent({Key? key}) : super(key: key);

  @override
  _GetEmailPageContentState createState() => _GetEmailPageContentState();
}

class _GetEmailPageContentState extends State<GetEmailPageContent> {
  @override
  void initState() {
    context.read<ForgotPasswordViewModel>().clearGetEmailFields();
    context.read<ForgotPasswordViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Building');
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Forgot Password', showBackButton: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 56.h, width: double.infinity),
          Align(
            alignment: Alignment.center,
            child: Text('Forgot Password', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
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
                  key: context.read<ForgotPasswordViewModel>().getEmailFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Text(
                        'Enter your Registered Email',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 26.h),
                      CustomTextFormField(
                        interactiveSelection: false,
                        maxLines: 1,
                        prefixIconPath: AppAssets.icEmailSvg,
                        keyboardType: TextInputType.emailAddress,
                        labelText: context.read<ForgotPasswordViewModel>().emailLabelText,
                        hintText: context.read<ForgotPasswordViewModel>().emailHintText,
                        controller: context.read<ForgotPasswordViewModel>().emailController,
                        focusNode: context.read<ForgotPasswordViewModel>().emailFocusNode,
                        validator: context.read<ForgotPasswordViewModel>().validateEmail,
                        onChanged: context.read<ForgotPasswordViewModel>().onEmailChange,
                        onFieldSubmitted: (_) => context.read<ForgotPasswordViewModel>().onEmailSubmitted(context),
                      ),
                      SizedBox(height: 26.h),
                      ContinueButton(
                        text: 'Send',
                        loadingNotifier: context.read<ForgotPasswordViewModel>().isForgotPasswordLoadingNotifier,
                        onPressed: () {
                          context.read<ForgotPasswordViewModel>().isButtonPressed = true;
                          if (!context.read<ForgotPasswordViewModel>().getEmailFormKey.currentState!.validate()) {
                            return;
                          }
                          context.read<ForgotPasswordViewModel>().forgotPassword();
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
