import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/globals.dart';
import '../manager/splash_view_model.dart';
import '../widgets/splash_page_content.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, snapshot) {
          return const SplashPageContent();
        },
      ),
    );
  }
}
