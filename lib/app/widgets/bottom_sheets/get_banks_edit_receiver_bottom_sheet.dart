import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';

class GetBankEditReceiverBottomSheet {
  final BuildContext context;
  final String country;

  GetBankEditReceiverBottomSheet(this.context, this.country);

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
                Text('Add Bank', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 3.h),
                Text('Select receiver bank', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context.read<ReceiverViewModel>().isBanksListLoadingNotifier,
                    builder: (_, isLoading, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: isLoading
                            ? Center(
                                child: SizedBox(
                                  height: 40.w,
                                  width: 40.w,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: context.read<ReceiverViewModel>().getBanks?.getBankListResponseModelBody.length ?? 0,
                                separatorBuilder: (BuildContext context, int index) {
                                  return Divider(thickness: 0.8, color: Colors.grey.withOpacity(0.8));
                                },
                                itemBuilder: (_, index) {
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
                                    title: Text(context.read<ReceiverViewModel>().getBanks?.getBankListResponseModelBody[index].name ?? '',
                                        style: Theme.of(context).textTheme.bodyText2),
                                    subtitle: Text(country.toUpperCase(), style: Theme.of(context).textTheme.caption),
                                    onTap: () {
                                      context.read<ReceiverViewModel>().bankController.text =
                                          context.read<ReceiverViewModel>().getBanks?.getBankListResponseModelBody[index].name ?? '';
                                      context.read<ReceiverViewModel>().bankId = context.read<ReceiverViewModel>().getBanks?.getBankListResponseModelBody[index].bankId.toString();
                                      context.read<ReceiverViewModel>().getBankListResponseModelBody =
                                          context.read<ReceiverViewModel>().getBanks?.getBankListResponseModelBody[index];
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
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
