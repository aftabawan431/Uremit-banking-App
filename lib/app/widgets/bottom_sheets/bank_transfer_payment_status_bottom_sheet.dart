import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';

import '../../../utils/constants/enums/page_state_enum.dart';
import '../../../utils/router/app_state.dart';
import '../../../utils/router/models/page_action.dart';
import '../../../utils/router/models/page_config.dart';
import '../../globals.dart';

class BankTransferPaymentStatusBottomSheet {
  final BuildContext context;
  final bool isDeleteReceiver;

  BankTransferPaymentStatusBottomSheet({required this.context, required this.isDeleteReceiver});

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 22.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('BANK TRANSFER', style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
                SizedBox(height: 16.h, width: double.infinity),
                Text('Manually Transfer Money From Your Bank', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 16.h),
                ContinueButton(
                  loadingNotifier: context.read<ReceiptScreenViewModel>().isLoadingNotifier,
                  text: 'I have Paid',
                  onPressed: () async {
                    AppState appState = sl();
                    appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.payIdUploadPageConfig);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  onPressed: () {
                    AppState appState = sl();
                    appState.currentAction = PageAction(state: PageState.replace, page: PageConfigs.summaryDetailsScreenPageConfig);
                    Navigator.of(context).pop();
                  },
                  child: Text('I\'ll Transfer Later', style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
