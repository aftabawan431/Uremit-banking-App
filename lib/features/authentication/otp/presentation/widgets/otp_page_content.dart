import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_otp_fields.dart';
import 'package:uremit/features/authentication/otp/presentation/manager/otp_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import '../../../../../app/globals.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../auth_wrapper/presentation/widgets/auth_salutation.dart';
import '../../../forgot_password/presentation/manager/forgot_password_view_model.dart';

class OtpPageContent extends StatefulWidget {
  const OtpPageContent({Key? key}) : super(key: key);

  @override
  _OtpPageContentState createState() => _OtpPageContentState();
}

class _OtpPageContentState extends State<OtpPageContent> {
  ForgotPasswordViewModel forgotPasswordViewModel = sl();
  OtpViewModel otpViewModel =sl();

  startTimer() async {
    Future.delayed(const Duration(seconds: 60), () {
      otpViewModel.startTimer();
      return;
    });
  }
  @override
  void initState() {
    context.read<OtpViewModel>().onErrorMessage = (value) => context.show(
        message: value.message, backgroundColor: value.backgroundColor);
    context.read<OtpViewModel>().otpController.clear();
    startTimer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: GestureDetector(
              onTap: () {
                GetIt.I.get<AppState>().moveToBackScreen();
              },
              child: CircleAvatar(
                radius: 14.r,
                backgroundColor: Colors.white.withOpacity(0.85),
                child: Center(
                  child: Icon(Icons.chevron_left_rounded,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: const AuthSalutation(),
          ),
          SizedBox(height: 26.h, width: double.infinity),
          Align(
            alignment: Alignment.center,
            child: Text('Email Verification',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white)),
          ),
          SizedBox(height: 22.h),
          Consumer<OtpViewModel>(
            builder: (context, provider, child) {
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(22.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r)),
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
                          // controller: context.read<OtpViewModel>().otpController,
                          // errorStream: context.read<OtpViewModel>().errorStream,
                          onChanged: context.read<OtpViewModel>().onChanged,
                          // onCompleted: context.read<OtpViewModel>().onCompleted,
                          beforeTextPaste:
                              context.read<OtpViewModel>().beforeTextPaste,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable:
                              context.read<OtpViewModel>().isLoadingNotifier,
                          builder: (_, value, __) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: value
                                  ? Center(
                                      child: SizedBox(
                                        height: 30.w,
                                        width: 30.w,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          strokeWidth: 2,
                                          backgroundColor: Colors.transparent,
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    )
                                  : provider.otpTimer == true
                                      ? Text('Wait until 30 seconds',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2)
                                      : TextButton(
                                          onPressed: () async {
                                            context
                                                .read<OtpViewModel>()
                                                .otpController
                                                .clear();
                                            provider.otpTimer == true;
                                            startTimer();
                                            await context
                                                .read<OtpViewModel>()
                                                .generateOtp();
                                          },
                                          child: Text('Resend Code',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2),
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 10.h),
                                              primary: Colors.transparent),
                                        ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
