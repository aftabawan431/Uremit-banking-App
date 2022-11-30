import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../utils/router/uremit_router_delegate.dart';


class DeleteReceiverInfoBottomSheet {
  final BuildContext context;
  final bool isDeleteReceiver;
  final String receiverId;
  final String bankId;

  DeleteReceiverInfoBottomSheet({required this.context, required this.isDeleteReceiver, this.receiverId = '', this.bankId = ''});

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(CupertinoIcons.delete, color: Theme.of(context).errorColor, size: 48.h),
                    SizedBox(width: 5.w),
                    Text('Delete', style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
                SizedBox(height: 16.h, width: double.infinity),
                Text('Are you sure you want to delete this', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 16.h),
                ContinueButton(
                  loadingNotifier: context.read<ReceiverViewModel>().isReceiverDeleteNotifier,
                  text: 'Delete',
                  onPressed: () async {
                    if (isDeleteReceiver) {
                      if (receiverId.isEmpty) {
                        return;
                      }
                      context.read<ReceiverViewModel>().deleteReceiver(context, receiverId);
                    } else {
                      if (bankId.isEmpty) {
                        return;
                      }

                      context.read<ReceiverViewModel>().deleteReceiverBank(context, bankId);
                    }
                  },
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor)),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      globalHomeContext = null;
    });
  }
}
