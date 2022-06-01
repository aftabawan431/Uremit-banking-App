import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/tabview/custom_tab_view.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/manager/auth_wrapper_view_model.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/widgets/auth_salutation.dart';
import 'package:uremit/features/authentication/login/presentation/pages/login_page.dart';
import 'package:uremit/features/authentication/rates/presentation/pages/rates_page.dart';
import 'package:uremit/features/authentication/registration/presentation/pages/registration_page.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/globals.dart';
import '../../../rates/presentation/manager/rates_view_model.dart';

class AuthWrapperPageContent extends StatefulWidget {
  const AuthWrapperPageContent({Key? key}) : super(key: key);

  @override
  _AuthWrapperPageContentState createState() => _AuthWrapperPageContentState();
}

class _AuthWrapperPageContentState extends State<AuthWrapperPageContent> {
  @override
  void initState() {
    context.read<AuthWrapperViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    RatesViewModel ratesViewModel=sl();
    ratesViewModel.isButtonPressed=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: const AuthSalutation(),
        ),
        SizedBox(height: 10.h),
        CustomTabView(
          key: context.read<AuthWrapperViewModel>().bottomNavigationKey,
          index: 0,
          height: 50.0,
          pages: const [
            LoginPage(),
            RegistrationPage(),
            RatesPage(),
          ],
          titles: const ['Login', 'Sign Up', 'Rates'],
          color: Colors.white,
          buttonBackgroundColor: Theme.of(context).indicatorColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          letIndexChange: (index) => true,
        )
      ],
    );
  }
}
