import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/widgets/auth_wrapper_page_content.dart';

import '../../../../../app/globals.dart';
import '../manager/auth_wrapper_view_model.dart';

class AuthWrapperPage extends StatefulWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  State<AuthWrapperPage> createState() => _AuthWrapperPageState();
}

class _AuthWrapperPageState extends State<AuthWrapperPage> {
  final AuthWrapperViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: ChangeNotifierProvider.value(
            value: _viewModel,
            builder: (context, snapshot) {
              return const AuthWrapperPageContent();
            },
          ),
        ),
      ),
    );
  }
}
