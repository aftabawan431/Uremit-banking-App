import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/manager/forgot_password_view_model.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/widgets/forgot_otp_page_content.dart';

import '../../../../../app/globals.dart';

class ForgotOtpPage extends StatefulWidget {
  const ForgotOtpPage({Key? key}) : super(key: key);

  @override
  State<ForgotOtpPage> createState() => _ForgotOtpPageState();
}

class _ForgotOtpPageState extends State<ForgotOtpPage> {
  final ForgotPasswordViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: ChangeNotifierProvider.value(
            value: _viewModel,
            builder: (context, snapshot) {
              return const ForgotOtpPageContent();
            },
          ),
        ),
      ),
    );
  }
}
