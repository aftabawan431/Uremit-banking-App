import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/app/widgets/customs/tabview/custom_tab_view.dart';
import 'package:uremit/features/payment/receiver_info/presentation/pages/receiver_info_page.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/presentation/widgets/payment_header.dart';

class AddReceiverInfoContent extends StatefulWidget {
  const AddReceiverInfoContent({Key? key}) : super(key: key);

  @override
  State<AddReceiverInfoContent> createState() => _AddReceiverInfoContentState();
}

class _AddReceiverInfoContentState extends State<AddReceiverInfoContent> {
  @override
  void initState() {
    context.read<ReceiverViewModel>().getPaymentHeaderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Receiver'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentHeader(),
          SizedBox(height: 10.h),
          CustomTabView(
            key: context.read<ReceiverViewModel>().bottomNavigationKey,
            index: 0,
            height: 50.0,
            pages: const [
              ReceiverInfoPage(),
            ],
            titles: const [
              'Receiver ',
            ],
            color: Colors.white,
            buttonBackgroundColor: Theme.of(context).indicatorColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            letIndexChange: (index) => true,
            onTap: (int i) {
              print(i);
            },
          )
        ],
      ),
    );
  }
}
