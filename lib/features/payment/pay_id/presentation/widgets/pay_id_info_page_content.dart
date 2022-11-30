import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/payment/pay_id/presentation/manager/pay_id_view_model.dart';
import 'package:uremit/features/payment/pay_id/presentation/widgets/bank_account_widget.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';
import '../../../payment_details/presentation/manager/payment_details_view_model.dart';
import 'pay_id_account_info_widget.dart';

class PayIdInfoPageContent extends StatefulWidget {
  const PayIdInfoPageContent({Key? key}) : super(key: key);

  @override
  _PayIdInfoPageContentState createState() => _PayIdInfoPageContentState();
}

class _PayIdInfoPageContentState extends State<PayIdInfoPageContent> {
  @override
  void initState() {
    context.read<PayIdInfoViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(title: context.read<ReceiptScreenViewModel>().isManualBankGateway ? 'Bank Transfer' : 'Pay Id'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h, width: double.infinity),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(context.read<ReceiptScreenViewModel>().isManualBankGateway ? 'Manual Bank Transfer' : 'Pay using Pay ID',
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
            ),
          ),
          SizedBox(height: 22.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(22.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          'Go to your online banking and transfer ${context.read<ReceiptScreenViewModel>().fromChangePaymentMethod ? context.read<ReceiptScreenViewModel>().updateTransaction!.sendingAmount : double.parse(context.read<PaymentDetailsViewModel>().sendMoneyController.text) + context.read<ReceiptScreenViewModel>().totalFee.value} AUD into our account using the ${context.read<ReceiptScreenViewModel>().isManualBankGateway ? 'Bank' : 'Pay ID'} below.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Once you have transfer the money,please upload the screenshot of transfer receipt.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 26.h),
                        context.read<ReceiptScreenViewModel>().isManualBankGateway ? BankAccountWidget() : PayIdAccountWidget(),
                      ],
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        AppState appState = sl();
                        appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.payIdUploadPageConfig);
                      },
                      child: Text('I have paid', style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor)),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ContinueButton(
                      text: 'I\'ll transfer later',
                      onPressed: () async {
                        context.read<PayIdInfoViewModel>().updateTransactionStatus();
                        AppState appState = sl();
                        appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.summaryDetailsScreenPageConfig);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
