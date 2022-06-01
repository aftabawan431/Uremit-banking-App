import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/manager/forgot_password_view_model.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/widgets/get_email_page_content.dart';

import '../../../../../app/globals.dart';

class GetEmailPage extends StatefulWidget {
  const GetEmailPage({Key? key}) : super(key: key);

  @override
  State<GetEmailPage> createState() => _GetEmailPageState();
}

class _GetEmailPageState extends State<GetEmailPage> {
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
              return const GetEmailPageContent();
            },
          ),
        ),
      ),
    );
  }
}
