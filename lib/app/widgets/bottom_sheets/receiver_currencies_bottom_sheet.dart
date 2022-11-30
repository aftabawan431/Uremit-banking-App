import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

class ReceiverCurrenciesBottomSheet {
  final BuildContext context;

  ReceiverCurrenciesBottomSheet({required this.context});

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.only(
                top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Currency',
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context
                        .read<PaymentDetailsViewModel>()
                        .isCurrencyLoading,
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                ),
                              )
                            : context
                                    .read<PaymentDetailsViewModel>()
                                    .getReceiverCurrenciesResponseModel!
                                    .Body
                                    .isEmpty
                                ? Center(
                                    child:
                                        Text("No currencies for this country"),
                                  )
                                : ListView.separated(
                                    itemCount: context
                                        .read<PaymentDetailsViewModel>()
                                        .getReceiverCurrenciesResponseModel!
                                        .Body
                                        .length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                          thickness: 0.8,
                                          color: Colors.grey.withOpacity(0.8));
                                    },
                                    itemBuilder: (_, index) {
                                      return GestureDetector(
                                        onTap: () {

                                        },
                                        child: ListTile(

                                          contentPadding: EdgeInsets.zero,
                                          leading: ClipOval(
                                            child: SizedBox(
                                              width: 40.w,
                                              height: 40.w,
                                              child: SvgPicture.asset(
                                                AppAssets.icSendMoneySvg,
                                                width: 40.w,
                                                height: 40.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title:  Text(
                                              context
                                                  .read<
                                                  PaymentDetailsViewModel>()
                                                  .getReceiverCurrenciesResponseModel!
                                                  .Body[index]
                                                  .name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                          onTap: () { context
                                              .read<PaymentDetailsViewModel>()
                                              .receiverCurrency
                                              .value =
                                          context
                                              .read<
                                              PaymentDetailsViewModel>()
                                              .getReceiverCurrenciesResponseModel!
                                              .Body[index];
                                          context
                                              .read<PaymentDetailsViewModel>()
                                              .receiverCurrencyController
                                              .text =
                                              context
                                                  .read<
                                                  PaymentDetailsViewModel>()
                                                  .getReceiverCurrenciesResponseModel!
                                                  .Body[index]
                                                  .name;

                                          Navigator.of(context).pop();

                                       },
                                        )


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
