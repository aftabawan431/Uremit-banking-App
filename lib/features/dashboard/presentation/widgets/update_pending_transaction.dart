import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/router/models/page_action.dart';
import '../../../../utils/router/models/page_config.dart';
import '../../../payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';

class UpdatePendingTransaction extends StatelessWidget {
  UpdatePendingTransaction({Key? key, required this.transaction})
      : super(key: key);
  TransactionList transaction;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ready to pay?',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white54),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _timeItem(context, 'Date', transaction.date),
                _timeItem(context, 'Time', transaction.time),
                _timeItem(
                    context, 'A/c Name', transaction.bankDetails.accountName),
                _timeItem(
                    context, 'A/c No.', transaction.bankDetails.accountNo),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'Next Sent your Money to your AUD account. We\'ll get started to  your transfer the moment to receive your money.',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Colors.white),
        ),
        SizedBox(height: 12.h),
        _dottedLine(),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (transaction.paymentGateway == '8' ||
                transaction.paymentGateway == '9')
              _button(
                  onTap: () {
                    ReceiptScreenViewModel _receiptScreen = sl();
                    _receiptScreen.updateTransaction = transaction;
                    _receiptScreen.fromChangePaymentMethod = true;
                    AppState appState = sl();
                    appState.currentAction = PageAction(
                        state: PageState.addPage,
                        page: PageConfigs.payIdUploadPageConfig);
                  },
                  context: context,
                  title: 'I\'ve paid now',
                  backgroundColor: const Color(0xFF6E6F6F),
                  borderColor: const Color(0xFF282A3C)),
            _button(
                context: context,
                title: 'Choose how to pay',
                backgroundColor: const Color(0xFF000812),
                borderColor: Colors.transparent,
                onTap: () {
                  if (transaction.isReceiverDeleted) {
                    context.show(
                        message: 'This user has been deleted',
                        backgroundColor: Colors.red);
                  } else {
                    ReceiverViewModel _receiverViewModel = sl();
                    _receiverViewModel.selectedReceiver.value =
                        _receiverViewModel.receiverList!.receiverListBody
                            .firstWhere((element) =>
                                element.receiverId == transaction.receiverId);
                    ReceiptScreenViewModel _receiptScreen = sl();
                    _receiptScreen.updateTransaction = transaction;
                    _receiptScreen.fromChangePaymentMethod = true;
                    _receiptScreen.isRepeatTransaction = false;
                    AppState appState = sl();
                    appState.currentAction = PageAction(
                        state: PageState.addPage,
                        page: PageConfigs.receiptScreenPageConfig);
                  }
                }),
          ],
        ),
        SizedBox(height: 12.h),
        // Align(
        //   alignment: Alignment.center,
        //   child: _button(
        //     context: context,
        //     title: 'Cancel Transfer',
        //     backgroundColor: Colors.transparent,
        //     borderColor: const Color(0xFFD60101),
        //     textColor: const Color(0xFFD60101),
        //   ),
        // ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _dottedLine() {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 2.0,
      dashLength: 8.0,
      dashColor: Colors.black,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
    );
  }

  Widget _button(
      {required BuildContext context,
      required String title,
      Function()? onTap,
      required Color backgroundColor,
      required Color borderColor,
      Color textColor = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: StadiumBorder(side: BorderSide(color: borderColor)),
          color: backgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: textColor)),
      ),
    );
  }

  Widget _timeItem(BuildContext context, String title, String details) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600),
        ),
        Text(
          details,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
