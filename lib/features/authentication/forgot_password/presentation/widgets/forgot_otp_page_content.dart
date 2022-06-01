import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/manager/forgot_password_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/widgets/customs/custom_otp_fields.dart';

class ForgotOtpPageContent extends StatefulWidget {
  const ForgotOtpPageContent({Key? key}) : super(key: key);

  @override
  _ForgotOtpPageContentState createState() => _ForgotOtpPageContentState();
}

class _ForgotOtpPageContentState extends State<ForgotOtpPageContent> {
  @override
  void initState() {
    context.read<ForgotPasswordViewModel>().clearForgotOtpFields();
    context.read<ForgotPasswordViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Forgot Password'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Column(
                  children: [
                    Text(
                      'We\'ve sent a 4-digit Code to your\nemail address.',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 44.h),
                    Text(
                      'Enter the 4-digit code',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 22.h),
                    CustomOtpFields(
                      controller: context.read<ForgotPasswordViewModel>().otpController,
                      errorStream: context.read<ForgotPasswordViewModel>().errorStream,
                      onChanged: context.read<ForgotPasswordViewModel>().onChanged,
                      onCompleted: context.read<ForgotPasswordViewModel>().onCompleted,
                      beforeTextPaste: context.read<ForgotPasswordViewModel>().beforeTextPaste,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: context.read<ForgotPasswordViewModel>().isGeneratePasswordLoadingNotifier,
                      builder: (_, value, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: value
                              ? Center(
                                  child: SizedBox(
                                    height: 30.w,
                                    width: 30.w,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                      backgroundColor: Colors.transparent,
                                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                    ),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    context.read<ForgotPasswordViewModel>().otpController.clear();
                                    await context.read<ForgotPasswordViewModel>().generateOtp();
                                  },
                                  child: Text('Resend Code', style: Theme.of(context).textTheme.subtitle2),
                                  style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), primary: Colors.transparent),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
