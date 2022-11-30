import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/payment/receipt_screen/modal/get_Payment_Method_Response_Model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/payment_method_widget.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/receipt_details.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/select_card_widget.dart';
import 'package:uremit/utils/constants/enums/page_state_enum.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import 'package:uremit/utils/router/app_state.dart';
import 'package:uremit/utils/router/models/page_action.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/widgets/clippers/receipt_details_clipper.dart';
import '../../../../../utils/router/models/page_config.dart';
import '../../../../cards/presentation/manager/cards_view_model.dart';
import '../../../../receivers/presentation/manager/receiver_view_model.dart';
import '../../../payment_details/presentation/manager/payment_details_view_model.dart';
import '../manager/receipt_screen_view_model.dart';

class ReceiptScreenPageContent extends StatefulWidget {
  const ReceiptScreenPageContent({Key? key}) : super(key: key);

  @override
  _ReceiptScreenPageContentState createState() =>
      _ReceiptScreenPageContentState();
}

class _ReceiptScreenPageContentState extends State<ReceiptScreenPageContent> {
  late bool fromUpdateGateway;

  @override
  void initState() {
    fromUpdateGateway =
        context.read<ReceiptScreenViewModel>().fromChangePaymentMethod;
    context.read<ReceiptScreenViewModel>().onErrorMessage = (value) => context
        .show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<ReceiptScreenViewModel>().getPaymentMethods();
    context.read<CardsViewModel>().getAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Receipt'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('How would you like to pay?',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder<bool>(
                valueListenable: context
                    .read<ReceiptScreenViewModel>()
                    .isPaymentMethodsLoading,
                builder: (_, loading, __) {
                  if (loading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                      ),
                    );
                  }

                  return ValueListenableBuilder<List<PaymentMethodBody>>(
                      valueListenable: context
                          .read<ReceiptScreenViewModel>()
                          .getPaymentMethodsBodyList,
                      builder: (_, value, __) {
                        return CarouselSlider(
                          options: CarouselOptions(
                              height: 100.h,
                              onPageChanged: (int index, value) {
                                context
                                        .read<ReceiptScreenViewModel>()
                                        .selectedPaymentMethod
                                        .value =
                                    context
                                        .read<ReceiptScreenViewModel>()
                                        .getPaymentMethodsBodyList
                                        .value[index];

                              }),
                          items: value.map((PaymentMethodBody item) {
                            return PaymentMethodWidget(paymentMethod: item);
                          }).toList(),
                        );
                      });
                }),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder<bool>(
                valueListenable: context
                    .read<ReceiptScreenViewModel>()
                    .isPaymentMethodsLoading,
                builder: (_, value, ch) {
                  if (value) {
                    return const SizedBox.shrink();
                  }
                  return ValueListenableBuilder<PaymentMethodBody?>(
                      valueListenable: context
                          .read<ReceiptScreenViewModel>()
                          .selectedPaymentMethod,
                      builder: (_, selectedPaymentMethod, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: (selectedPaymentMethod != null &&
                                  (selectedPaymentMethod.id == 11))
                              ? ValueListenableBuilder<bool>(
                                  valueListenable: context
                                      .read<CardsViewModel>()
                                      .isLoadingNotifier,
                                  builder: (_, cardsLoading, __) {
                                    return AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: cardsLoading
                                          ? const Center(

                                              child: CircularProgressIndicator.adaptive(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const SelectCardWidget(),
                                    );
                                  },
                                )
                              : const SizedBox.shrink(),
                        );
                      });
                }),
            ValueListenableBuilder<bool>(
                valueListenable: context
                    .read<ReceiptScreenViewModel>()
                    .isPaymentMethodsLoading,
                builder: (_, isLoadingValue, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isLoadingValue == true
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipPath(
                              clipper: ReceiptDetailsClipper(),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.w, vertical: 14.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.white,
                                  // gradient: const LinearGradient(
                                  //   begin: Alignment.topRight,
                                  //   end: Alignment.bottomLeft,
                                  //   colors: [
                                  //     Color(0xFF404152),
                                  //     Color(0xFF383A45),
                                  //   ],
                                  // ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h),
                                     ReceiptDetails(),
                                    // const UpdatePendingTransaction(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipPath(
                      clipper: ReceiptDetailsClipper(),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white,
                          // gradient: const LinearGradient(
                          //   begin: Alignment.topRight,
                          //   end: Alignment.bottomLeft,
                          //   colors: [
                          //     Color(0xFF404152),
                          //     Color(0xFF383A45),
                          //   ],
                          // ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                             ReceiptDetails(),
                            // const UpdatePendingTransaction(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.center,
              child: ValueListenableBuilder<bool>(
                  valueListenable: context
                      .read<ReceiptScreenViewModel>()
                      .insertPaymentLoading,
                  builder: (_, value, __) {
                    if (value) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          // strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          if (!validate()) {
                            return;
                          }
                          handleNext();
                          return;
                          // if(context.read<ReceiptScreenViewModel>().selectedPaymentMethod=="Bank")

                          AppState appState = sl();
                          appState.currentAction = PageAction(
                              state: PageState.addPage,
                              page: PageConfigs.payIdInfoPageConfig);
                        },
                        child: Container(
                          height: 40.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
            SizedBox(height: 15.h),
            // GestureDetector(
            //   child: Center(
            //     child: Text(
            //       'Looking for different way to pay?',
            //       style: Theme.of(context).textTheme.bodyText2?.copyWith(
            //             color: Colors.blue,
            //             fontSize: 12.sp,
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.underline,
            //           ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  bool validate() {
    PaymentDetailsViewModel paymentDetailsViewModel =
        GetIt.I.get<PaymentDetailsViewModel>();
    ReceiverViewModel receiverViewModel = GetIt.I.get<ReceiverViewModel>();
    ReceiptScreenViewModel receiptScreenViewModel =
        GetIt.I.get<ReceiptScreenViewModel>();

    //validations
    if (receiptScreenViewModel.isPaymentThreeSixty()) {}

    if (paymentDetailsViewModel.isAccountDeposit.value) {
      if (receiverViewModel.selectedReceiverBank.value == null) {
        context.show(
            message: 'No bank has been selected', backgroundColor: Colors.red);
        return false;
      }
    }

    return true;
  }

  handleNext() async {
    var selectedMethod =
        context.read<ReceiptScreenViewModel>().selectedPaymentMethod.value;
    if (selectedMethod == null) {
      context.show(message: 'No payment method selected');
      return;
    }
    PaymentDetailsViewModel paymentDetailsViewModel =
        GetIt.I.get<PaymentDetailsViewModel>();

    if (paymentDetailsViewModel.isAccountDeposit.value ||
        (context.read<ReceiptScreenViewModel>().fromChangePaymentMethod &&
            context
                    .read<ReceiptScreenViewModel>()
                    .updateTransaction!
                    .payoutMethod ==
                'Account Deposit')) {
      if (context.read<ReceiverViewModel>().selectedReceiverBank.value ==
          null) {
        context.show(message: 'No bank found');
        return;
      }
    }

    // Credit debit card idz
    if (selectedMethod.id.toString() == '11') {
      // go to payment365
      context.read<ReceiptScreenViewModel>().insertPayment(context);
    } else if (selectedMethod.id.toString() == '8') {
      context.read<ReceiptScreenViewModel>().insertPayment(context);
      // go to payid screen
      // goToPayId();
    } else if (selectedMethod.id == 7) {
      //poly
      context.read<ReceiptScreenViewModel>().insertPayment(context);
    } else if (selectedMethod.id.toString() == '9') {
      context.read<ReceiptScreenViewModel>().insertPayment(context);
      // BankTransferPaymentStatusBottomSheet bottomSheet =
      //     BankTransferPaymentStatusBottomSheet(
      //         context: context, isDeleteReceiver: false);
      // bottomSheet.show();
    }
  }

  goToPayId() {
    AppState appState = sl();
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.payIdInfoPageConfig);
  }
}
