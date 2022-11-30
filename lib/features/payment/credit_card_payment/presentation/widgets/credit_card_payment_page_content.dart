import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';
import '../manager/credit_card_payment_view_model.dart';

class CreditCardPaymentPageContent extends StatefulWidget {
  const CreditCardPaymentPageContent({Key? key}) : super(key: key);

  @override
  _CreditCardPaymentPageContentState createState() => _CreditCardPaymentPageContentState();
}

class _CreditCardPaymentPageContentState extends State<CreditCardPaymentPageContent> {
  @override
  void initState() {
    context.read<CreditCardPaymentViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '365 Payment',
          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
        ),
        titleSpacing: 0.3,
        leading: CircleAvatar(
          radius: 10.r,
          backgroundColor: Colors.black.withOpacity(0.85),
          child: const Icon(Icons.chevron_left_rounded, color: Colors.white),
        ),
        actions: [
          SvgPicture.asset(AppAssets.uremitSvg, width: 75.w),
          SizedBox(width: 22.w),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Uremit.com.au',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: 40.h, width: double.infinity),
        ],
      ),
    );
  }
}
