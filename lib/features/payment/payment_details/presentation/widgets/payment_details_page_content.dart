import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/models/general_status_model.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/payment_details/models/get_rate_lists_response_model.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/manager/payment_wrapper_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../app/globals.dart';
import '../../../../../app/widgets/bottom_sheets/payment_details_receiver_country_bottom_sheet.dart';
import '../../../../../app/widgets/bottom_sheets/payment_method_bottom_screen.dart';
import '../../../../../app/widgets/bottom_sheets/payout_partner_bottom_sheet.dart';
import '../../../../../app/widgets/bottom_sheets/receiver_currencies_bottom_sheet.dart';
import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../../utils/encryption/encryption.dart';
import '../../../../../utils/globals/app_globals.dart';
import '../../../../../utils/router/app_state.dart';
import '../../../../../utils/router/models/page_action.dart';
import '../../../../../utils/router/models/page_config.dart';
import '../../../receiver_info/presentation/manager/receiver_info_view_model.dart';
import '../manager/payment_details_view_model.dart';

class PaymentDetailsPageContent extends StatefulWidget {
  const PaymentDetailsPageContent({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsPageContent> createState() =>
      _PaymentDetailsPageContentState();
}

class _PaymentDetailsPageContentState extends State<PaymentDetailsPageContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PaymentDetailsViewModel>().getRateList();
    context.read<PaymentDetailsViewModel>().clearAllTextFields();
    checkProfileUpdateStatus();
  }

  checkProfileUpdateStatus() async {
    HomeViewModel homeViewModel = sl();
    await homeViewModel.getProfileAdminApprovel();
    if (homeViewModel.getProfileAdminApprovalResponseModel != null) {
      if (!homeViewModel
          .getProfileAdminApprovalResponseModel!.body.isAdminApproved) {
        DisplayStatusModel model = DisplayStatusModel(context,
            title: '',
            content:
                'Your profile update is pending please wait we\'ll send you an email',
            onDone: () {
          AppState appState = sl();
          appState.moveToBackScreen();
        });
        model.show();
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ValueListenableBuilder<bool>(
        valueListenable:
            context.read<PaymentDetailsViewModel>().isLoadingNotifier,
        builder: (_, value, __) {
          if (value) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          }
          if (context.read<PaymentDetailsViewModel>().getReceiverCountries ==
              null) {
            return Center(
                child: Text('Something Went Wrong!',
                    style: Theme.of(context).textTheme.caption));
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
            child: Form(
              key:
                  context.read<PaymentDetailsViewModel>().paymentDetailsFormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Details',
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      maxLines: 1,
                      readOnly: true,
                      prefixIconPath: AppAssets.icCountrySvg,
                      keyboardType: TextInputType.name,
                      labelText: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCountryLabelText,
                      hintText: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCountryHintText,
                      controller: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCountryController,
                      focusNode: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCountryFocusNode,
                      suffix: Icon(Icons.keyboard_arrow_down_rounded,
                          color: Theme.of(context).canvasColor),
                      validator: context
                          .read<PaymentDetailsViewModel>()
                          .validateReceiverCountry,
                      onChanged: context
                          .read<PaymentDetailsViewModel>()
                          .onReceiverCountryChange,
                      onFieldSubmitted: (_) => context
                          .read<PaymentDetailsViewModel>()
                          .onReceiverCountrySubmitted(context),
                      onTap: () async {
                        ReceiverCountriesBottomSheet bottomSheet =
                            ReceiverCountriesBottomSheet(
                                context: context, type: 0);
                        context
                            .read<PaymentDetailsViewModel>()
                            .getUniqueCountries();
                        context
                            .read<PaymentDetailsViewModel>()
                            .emptyPayoutMethods();
                        context
                            .read<PaymentDetailsViewModel>()
                            .paymentMethodController
                            .text = '';
                        context
                            .read<PaymentDetailsViewModel>()
                            .payoutPartnerController
                            .text = '';
                        context
                            .read<PaymentDetailsViewModel>()
                            .receiverCurrencyController
                            .text = '';
                        context
                            .read<PaymentDetailsViewModel>()
                            .receiverPayoutMethod
                            .value = null;
                        context
                            .read<PaymentDetailsViewModel>()
                            .receiverPayoutPartner
                            .value = null;
                        context
                            .read<PaymentDetailsViewModel>()
                            .receiverCurrency
                            .value = null;

                        await bottomSheet.show();
                      },
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      maxLines: 1,
                      readOnly: true,
                      prefixIconPath: AppAssets.icSendMoneySvg,
                      keyboardType: TextInputType.name,
                      labelText: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCurrencyLabelText,
                      hintText: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCountryHintText,
                      controller: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCurrencyController,
                      focusNode: context
                          .read<PaymentDetailsViewModel>()
                          .receiverCurrencyFocusNode,
                      suffix: Icon(Icons.keyboard_arrow_down_rounded,
                          color: Theme.of(context).canvasColor),
                      validator: context
                          .read<PaymentDetailsViewModel>()
                          .validateReceiverCurrency,
                      onChanged: context
                          .read<PaymentDetailsViewModel>()
                          .onReceiverCurrencyChange,
                      onFieldSubmitted: (_) => context
                          .read<PaymentDetailsViewModel>()
                          .onReceiverCurrencySubmitted(context),
                      onTap: () async {
                        if (context
                                .read<PaymentDetailsViewModel>()
                                .getReceiverCurrenciesResponseModel ==
                            null) {
                          return;
                        }

                        var bottomSheet =
                            ReceiverCurrenciesBottomSheet(context: context);

                        await bottomSheet.show();
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      maxLines: 1,
                      readOnly: true,
                      prefixIconPath: AppAssets.icPaymentMethodSvg,
                      keyboardType: TextInputType.name,
                      labelText: context
                          .read<PaymentDetailsViewModel>()
                          .paymentMethodLabelText,
                      hintText: context
                          .read<PaymentDetailsViewModel>()
                          .paymentMethodHintText,
                      controller: context
                          .read<PaymentDetailsViewModel>()
                          .paymentMethodController,
                      focusNode: context
                          .read<PaymentDetailsViewModel>()
                          .paymentMethodFocusNode,
                      suffix: Icon(Icons.keyboard_arrow_down_rounded,
                          color: Theme.of(context).canvasColor),
                      validator: context
                          .read<PaymentDetailsViewModel>()
                          .validatePaymentMethod,
                      onChanged: context
                          .read<PaymentDetailsViewModel>()
                          .onPaymentMethodChange,
                      onFieldSubmitted: (_) => context
                          .read<PaymentDetailsViewModel>()
                          .onPaymentMethodSubmitted(context),
                      onTap: () async {
                        PaymentMethodBottomSheet bottomSheet =
                            PaymentMethodBottomSheet(context);
                        context
                            .read<PaymentDetailsViewModel>()
                            .getPayoutMethods();
                        context
                            .read<PaymentDetailsViewModel>()
                            .emptyPayoutPartners();
                        context
                            .read<PaymentDetailsViewModel>()
                            .receiverPayoutPartner
                            .value = null;

                        context
                            .read<PaymentDetailsViewModel>()
                            .payoutPartnerController
                            .text = '';

                        context
                            .read<PaymentDetailsViewModel>()
                            .receiverPayoutPartner
                            .value = null;
                        await bottomSheet.show();
                      },
                    ),
                    SizedBox(height: 16.h),
                    ValueListenableBuilder<bool>(
                        valueListenable: context
                            .read<PaymentDetailsViewModel>()
                            .isAccountDeposit,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: !value
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextFormField(
                                        maxLines: 1,
                                        readOnly: true,
                                        prefixIconPath:
                                            AppAssets.icPaymentMethodSvg,
                                        keyboardType: TextInputType.name,
                                        labelText: context
                                            .read<PaymentDetailsViewModel>()
                                            .payoutPartnerLabelText,
                                        hintText: context
                                            .read<PaymentDetailsViewModel>()
                                            .payoutPartnerHintText,
                                        controller: context
                                            .read<PaymentDetailsViewModel>()
                                            .payoutPartnerController,
                                        focusNode: context
                                            .read<PaymentDetailsViewModel>()
                                            .payoutPartnerFocusNode,
                                        suffix: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color:
                                                Theme.of(context).canvasColor),
                                        validator: context
                                            .read<PaymentDetailsViewModel>()
                                            .validatePayoutPartner,
                                        onChanged: context
                                            .read<PaymentDetailsViewModel>()
                                            .onPayoutPartnerChange,
                                        onFieldSubmitted: (_) => context
                                            .read<PaymentDetailsViewModel>()
                                            .onPayoutPartnerSubmitted(context),
                                        onTap: () async {
                                          PayoutPartnerBottomSheet bottomSheet =
                                              PayoutPartnerBottomSheet(context);

                                          context
                                              .read<PaymentDetailsViewModel>()
                                              .getPayoutPartners();

                                          await bottomSheet.show();
                                        },
                                      ),
                                      if (!value)
                                        SizedBox(
                                          height: 7.h,
                                        )
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          );
                        }),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    // ValueListenableBuilder<PayoutMethod?>(
                    //     valueListenable: context.read<PaymentDetailsViewModel>().receiverPayoutMethod,
                    //     builder: (_, paymentMethod, __) {
                    //       if (paymentMethod != null) {
                    //         return Align(alignment: Alignment.centerRight, child: Text('Fee = ${paymentMethod.fee} AUD', style: Theme.of(context).textTheme.subtitle2));
                    //       } else {
                    //         return const SizedBox.shrink();
                    //       }
                    //     }),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                      maxLines: 1,
                      prefixIconPath: AppAssets.icSendMoneySvg,
                      keyboardType: TextInputType.number,
                      labelText: context
                          .read<PaymentDetailsViewModel>()
                          .sendMoneyLabelText,
                      hintText: context
                          .read<PaymentDetailsViewModel>()
                          .sendMoneyHintText,
                      controller: context
                          .read<PaymentDetailsViewModel>()
                          .sendMoneyController,
                      focusNode: context
                          .read<PaymentDetailsViewModel>()
                          .sendMoneyFocusNode,
                      validator: context
                          .read<PaymentDetailsViewModel>()
                          .validateSendMoney,
                      onChanged: context
                          .read<PaymentDetailsViewModel>()
                          .onSendMoneyChange,
                      onFieldSubmitted: (_) => context
                          .read<PaymentDetailsViewModel>()
                          .onSendMoneySubmitted(context),
                      onTap: () async {},
                    ),
                    SizedBox(height: 12.h),
                    // ValueListenableBuilder<PayoutPartner?>(
                    //     valueListenable: context.read<PaymentDetailsViewModel>().receiverPayoutPartner,
                    //     builder: (_, payoutPartner, __) {
                    //       if (payoutPartner != null) {
                    //         return Align(alignment: Alignment.centerRight, child: Text('Fee = ${payoutPartner.fee} AUD', style: Theme.of(context).textTheme.subtitle2));
                    //       } else {
                    //         return const SizedBox.shrink();
                    //       }
                    //     }),
                    // SizedBox(height: 4.h),
                    CustomTextFormField(
                      showLimitText: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(regexToRemoveEmoji))
                      ],
                      maxLines: 1,
                      maxLength: 40,
                      maxLengthEnforced: true,
                      prefixIconPath: AppAssets.icReasonSvg,
                      keyboardType: TextInputType.name,
                      labelText: context
                          .read<PaymentDetailsViewModel>()
                          .reasonCountryLabelText,
                      hintText: context
                          .read<PaymentDetailsViewModel>()
                          .reasonHintText,
                      controller: context
                          .read<PaymentDetailsViewModel>()
                          .reasonController,
                      focusNode: context
                          .read<PaymentDetailsViewModel>()
                          .reasonFocusNode,
                      validator: context
                          .read<PaymentDetailsViewModel>()
                          .validateReason,
                      onChanged: context
                          .read<PaymentDetailsViewModel>()
                          .onReasonChange,
                      onFieldSubmitted: (_) => context
                          .read<PaymentDetailsViewModel>()
                          .onReasonSubmitted(context),
                      onTap: () async {},
                    ),
                    SizedBox(height: 16.h),

                    ContinueButton(
                      loadingNotifier: context
                          .read<ReceiverInfoViewModel>()
                          .isGetAdminFeeLoadingNotifier,
                      text: 'Proceed Payment',
                      onPressed: () async {
                        HomeViewModel homeViewModel = sl();
                        await homeViewModel.getProfileAdminApprovel();
                        if (homeViewModel
                                .getProfileAdminApprovalResponseModel !=
                            null) {
                          if (!homeViewModel
                              .getProfileAdminApprovalResponseModel!
                              .body
                              .isAdminApproved) {
                            DisplayStatusModel model = DisplayStatusModel(
                                context,
                                title: '',
                                content:
                                    'Your profile update is pending please wait we\'ll send you an email',
                                onDone: () {
                              AppState appState = sl();
                              appState.moveToBackScreen();
                            });
                            model.show();
                            return;
                          }
                        }

                        FocusScope.of(context).unfocus();
                        PaymentDetailsViewModel paymentDetailsViewModel = sl();
                        ReceiverViewModel receiverViewModel = sl();

                        ReceiptScreenViewModel _receiptScreen = sl();
                        _receiptScreen.fromChangePaymentMethod = false;
                        final result = context
                            .read<PaymentDetailsViewModel>()
                            .validateForm();
                        if (result == true) {
                          if (validateOthers()) {
                            if (context
                                    .read<PaymentDetailsViewModel>()
                                    .receiverCurrency
                                    .value ==
                                null) {
                              context.show(
                                  message: 'Please choose a currency!');
                            }
                            Logger()
                                .v(paymentDetailsViewModel.receiverCountry!.id);
                            Logger().v(Encryption.encryptObject(
                                receiverViewModel
                                    .selectedReceiver.value!.countryId));
                            if (paymentDetailsViewModel.receiverCountry!.id !=
                                Encryption.encryptObject(receiverViewModel
                                    .selectedReceiver.value!.countryId)) {
                              context.show(
                                  message:
                                      "Receiver country doesn't match with selected receiver",
                                  backgroundColor: Colors.red);
                              return;
                            }

                            await context
                                .read<ReceiverInfoViewModel>()
                                .getAdminFee();
                          }
                        }
                        return;
                        if (result == false) {
                          return;
                        }

                        // context.read<PaymentWrapperViewModel>().buttonTap(1);
                        // AppState appState = sl();
                        // appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.receiptScreenPageConfig);
                        //
                        // return;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool validateOthers() {
    if (context
        .read<HomeViewModel>()
        .profileHeader!
        .profileHeaderBody
        .first
        .fullName
        .isEmpty) {
      context.show(
          message: 'Complete your profile information first',
          backgroundColor: Colors.red);
      context.read<PaymentWrapperViewModel>().buttonTap(2);
      return false;
    }

    if (context.read<ReceiverViewModel>().selectedReceiver.value == null) {
      if (context
          .read<ReceiverViewModel>()
          .receiverList!
          .receiverListBody
          .isEmpty) {
        // context.read<ReceiverInfoViewModel>().countryId=context.read<ReceiverViewModel>().receiverList!.receiverListBody.where((element) => element.receiverId.contains(element.countryId));
        context.show(
            message: 'You have no receiver please add one',
            backgroundColor: Colors.red);
        context.read<PaymentWrapperViewModel>().buttonTap(1);
        return false;
      }

      DisplayStatusModel model = DisplayStatusModel(context,
          title: '', content: 'Please choose receiver from top');
      model.show();
      // context.show(
      //   message: 'Select receiver from top',
      //   backgroundColor: Colors.red,
      // );
      return false;
    }
    return true;
  }
}
