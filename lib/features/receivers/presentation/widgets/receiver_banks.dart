import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/app/widgets/bottom_sheets/add_new_bank_bottom_sheet.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';

import '../../../../app/widgets/bottom_sheets/delete_receiver_info_bottom_sheet.dart';
import '../../../../utils/router/uremit_router_delegate.dart';
import '../manager/receiver_view_model.dart';

class ReceiverBanks extends StatelessWidget {
  const ReceiverBanks({required this.receiverBanks, required this.countryName, required this.receiverId, required this.countryId, Key? key}) : super(key: key);

  final List<ReceiverBank> receiverBanks;
  final String countryId;
  final String receiverId;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.4,
      color: Colors.black12,
      offset: const Offset(0, 0),
      sigma: 3,
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF7FCFF),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SimpleShadow(
              opacity: 0.5,
              color: Colors.black12,
              offset: const Offset(0, 0),
              sigma: 5,
              child: GestureDetector(
                onTap: () {
                  context.read<ReceiverViewModel>().clearAddBankInfo();
                  AddBankBottomSheet bottomSheet =
                      AddBankBottomSheet(context: context, isDeleteReceiver: false, countryId: countryId, countryName: countryName, receiverId: receiverId);
                  context.read<ReceiverViewModel>().getBanksList(countryId);
                  globalHomeContext = context;
                  bottomSheet.show();
                },
                child: Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  child: Text('Add Bank', style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            if (receiverBanks.isEmpty)
              Expanded(
                child: Center(
                  child: Text('No banks added', style: Theme.of(context).textTheme.caption),
                ),
              ),
            if (receiverBanks.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: receiverBanks.length,
                  itemBuilder: (_, index) {
                    return SimpleShadow(
                      opacity: 0.5,
                      color: Colors.black12,
                      offset: const Offset(0, 0),
                      sigma: 5,
                      child: Container(
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFD7E7F1),
                              Colors.white,
                            ],
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(receiverBanks[index].accountTitle, style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                                Text(receiverBanks[index].accountNumber, style: Theme.of(context).textTheme.overline),
                              ],
                            ),
                            GestureDetector(
                              child: const Icon(CupertinoIcons.delete, color: Colors.redAccent),
                              onTap: () {
                                DeleteReceiverInfoBottomSheet _bottomSheet =
                                    DeleteReceiverInfoBottomSheet(context: context, isDeleteReceiver: false, bankId: receiverBanks[index].id);
                                globalHomeContext = context;
                                _bottomSheet.show();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
