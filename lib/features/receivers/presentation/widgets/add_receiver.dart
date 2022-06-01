import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uremit/app/widgets/customs/tabview/custom_tab_view.dart';

import '../../../../app/widgets/customs/custom_app_bar.dart';
import '../../../payment/payment_wrapper/presentation/widgets/payment_header.dart';
import '../../../payment/receiver_info/presentation/pages/receiver_info_page.dart';

class AddReciver extends StatefulWidget {
  const AddReciver({Key? key}) : super(key: key);

  @override
  State<AddReciver> createState() => _AddReciverState();
}

class _AddReciverState extends State<AddReciver> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Receiver'),
      body: Column(
        children: [
          const PaymentHeader(),
          SizedBox(height: 10.h),
          CustomTabView(
            titles: const ['Receiver Info'],
            pages: const [
              ReceiverInfoPage(),
            ],
            index: 0,
            height: 50.0,
            buttonBackgroundColor: Theme.of(context).indicatorColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            letIndexChange: (index) => true,
            onTap: (int i) {
              print(i);
            },
          ),
        ],
      ),
    );
  }
}
