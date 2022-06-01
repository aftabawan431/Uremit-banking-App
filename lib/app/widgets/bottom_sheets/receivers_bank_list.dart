import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';

class ReceiversBankListBottomSheet {
  final BuildContext context;

  ReceiversBankListBottomSheet(this.context);

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
            padding: EdgeInsets.only(top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select receiver bank', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: context.read<ReceiverViewModel>().selectedReceiver.value!.banks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(thickness: 0.8, color: Colors.grey.withOpacity(0.8));
                    },
                    itemBuilder: (_, index) {
                      var bank = context.read<ReceiverViewModel>().selectedReceiver.value!.banks[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipOval(
                          child: SizedBox(
                            width: 40.w,
                            height: 40.w,
                            child: SvgPicture.asset(
                              AppAssets.icDocumentTypeSvg,
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(bank.accountTitle, style: Theme.of(context).textTheme.bodyText2),
                        subtitle: Text(bank.accountNumber, style: Theme.of(context).textTheme.caption),
                        onTap: () {
                          context.read<ReceiverViewModel>().selectedReceiverBank.value = bank;

                          Navigator.of(context).pop();
                        },
                      );
                    },
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
