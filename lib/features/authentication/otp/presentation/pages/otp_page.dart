import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/otp/presentation/manager/otp_view_model.dart';

import '../../../../../app/globals.dart';
import '../widgets/otp_page_content.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final OtpViewModel _viewModel = sl();

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
              return const OtpPageContent();
            },
          ),
        ),
      ),
    );
  }
}
