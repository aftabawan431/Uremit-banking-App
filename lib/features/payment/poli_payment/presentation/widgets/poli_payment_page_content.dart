import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../utils/constants/app_level/app_assets.dart';
import '../manager/poli_payment_view_model.dart';

class PoliPaymentPageContent extends StatefulWidget {
  const PoliPaymentPageContent({Key? key}) : super(key: key);

  @override
  _PoliPaymentPageContentState createState() => _PoliPaymentPageContentState();
}

class _PoliPaymentPageContentState extends State<PoliPaymentPageContent> {
  @override
  void initState() {
    context.read<PoliPaymentViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Payment with bank',
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
          Container(
            alignment: Alignment.topLeft,
            color: Colors.grey[300],
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.icRedLogoSvg,
                  height: 30.h,
                  width: 30.h,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 30.h,
                  width: 2.w,
                  color: Colors.grey,
                ),
                SvgPicture.asset(
                  AppAssets.icPoliPaymentSvg,
                  height: 50.h,
                  width: 50.w,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'You are Paying',
              style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            color: Colors.grey[300],
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    AppAssets.uremitLogoSvg,
                    height: 50.h,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'U-REMIT PAY LTD',
                        style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Amount: ',
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\$150.00',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Reference: ',
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Testing123',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'POLi ID: ',
                          style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                              text: '150009824624878',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'Select your bank',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            height: 35,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black87, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton<String>(
                // Initial Value
                isExpanded: true,
                underline: Container(),
                iconEnabledColor: Colors.black, //empty line
                style: const TextStyle(fontSize: 14, color: Colors.black),
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (value) {},
                items: const [],
                // Array list of items
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: RichText(
              text: TextSpan(
                text: 'By clicking on continue you agree to our ',
                style: Theme.of(context).textTheme.bodyText2,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Privacy Policy ',
                    style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 12),
                  ),
                  TextSpan(
                    text: 'and our',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  TextSpan(
                    text: 'Terms and Conditions.',
                    style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            color: Colors.grey[300],
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.icLockSvg),
                    SizedBox(
                      width: 5.h,
                    ),
                    const Text(
                      '  Security \ninformation',
                      style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.question_mark,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    const Text(
                      'Support',
                      style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h, width: double.infinity),
        ],
      ),
    );
  }
}
