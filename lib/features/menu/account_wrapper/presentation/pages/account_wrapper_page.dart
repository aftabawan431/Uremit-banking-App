import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/manager/account_wrapper_view_model.dart';

import '../../../../../app/globals.dart';
import '../../../profile/presentation/manager/profile_view_model.dart';
import '../../../update_profile/presentation/manager/update_profile_view_model.dart';
import '../widgets/account_wrapper_page_content.dart';

class AccountWrapperPage extends StatefulWidget {
  const AccountWrapperPage({Key? key}) : super(key: key);

  @override
  State<AccountWrapperPage> createState() => _AccountWrapperPageState();
}

class _AccountWrapperPageState extends State<AccountWrapperPage> {
  final AccountWrapperViewModel _viewModel = sl();
  final ProfileViewModel _viewModelProfile = sl();
  final UpdateProfileViewModel _viewModelUpdateProfile = sl();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: _viewModel),
                ChangeNotifierProvider.value(value: _viewModelProfile),
                ChangeNotifierProvider.value(value: _viewModelUpdateProfile),
              ],
              child: const AccountWrapperPageContent(),
            )),
      ),
    );
  }
}
