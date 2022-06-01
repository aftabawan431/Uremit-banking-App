import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/login/presentation/manager/login_view_model.dart';

import '../../../../../app/globals.dart';
import '../widgets/login_page_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider.value(
          value: _viewModel,
          builder: (context, snapshot) {
            return const LoginPageContent();
          },
        ),
      ),
    );
  }
}
