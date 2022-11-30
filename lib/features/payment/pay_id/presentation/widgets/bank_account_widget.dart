import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../receipt_screen/presentation/manager/receipt_screen_view_model.dart';

class BankAccountWidget extends StatelessWidget {
  const BankAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.6,
      color: Colors.black12,
      offset: const Offset(0, 0),
      sigma: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF828E95),
                Color(0xFF617887),

              ]),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            _detailItem(
                context: context,
                title: 'PayID (ABN/ACN: 642800351)',
                detail: context
                    .read<ReceiptScreenViewModel>()
                    .manualBankResponseModal!
                    .Body
                    .accountNo),
            const Divider(thickness: 1.5),
            _detailItem(
                context: context,
                title: 'Account Name',
                detail: context
                    .read<ReceiptScreenViewModel>()
                    .manualBankResponseModal!
                    .Body
                    .accountName),
            const Divider(thickness: 1.5),
            _detailItem(
              context: context,
              title: 'Reference Id',
              detail: context
                  .read<ReceiptScreenViewModel>()
                  .manualBankResponseModal!
                  .Body
                  .txn,
            )
          ],
        ),
      ),
    );
  }

  Widget _detailItem(
      {required BuildContext context,
      required String title,
      required String detail}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.white),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(detail,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.white),
              textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
