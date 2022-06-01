import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/widgets/custom_payment_navbar.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/widgets/receivers_header.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../payment_details/presentation/pages/payment_details_page.dart';
import '../../../personal_info/presentation/pages/personal_info_page.dart';
import '../../../receiver_info/presentation/pages/receiver_info_page.dart';
import '../manager/payment_wrapper_view_model.dart';

class PaymentWrapperPageContent extends StatefulWidget {
  const PaymentWrapperPageContent({Key? key}) : super(key: key);

  @override
  _PaymentWrapperPageContentState createState() => _PaymentWrapperPageContentState();
}

class _PaymentWrapperPageContentState extends State<PaymentWrapperPageContent> {
  HomeViewModel homeViewModel=sl();
  @override
  void initState() {
    context.read<PaymentWrapperViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'New Payment'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const PaymentHeader(),
          ReceiversHeaders(),
          SizedBox(height: 10.h),
          CustomPaymentTabBar(
            key: context.read<PaymentWrapperViewModel>().bottomNavigationKey,
            index: 0,
            isPaymentPage: false,

            height: 50.0,

            pages:  [
              const PaymentDetailsPage(),
              const ReceiverInfoPage(),
              if(homeViewModel.profileHeader!.profileHeaderBody.first.fullName.isEmpty)
              const ProfileInfoPage(),
            ],
            titles:  [
              'Payment Details',
              'Receiver Info ',
              if(homeViewModel.profileHeader!.profileHeaderBody.first.fullName.isEmpty)
              'Personal Info',
            ],
            color: Colors.white,
            buttonBackgroundColor: Theme.of(context).indicatorColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            letIndexChange: (index) => true,
            onTap: (int i){
              print(i);

            },
          )
        ],
      ),
    );
  }
}
