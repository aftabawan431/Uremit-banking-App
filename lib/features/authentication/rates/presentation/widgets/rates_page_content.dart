import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/rate_list_bottom_sheet.dart';
import 'package:uremit/features/authentication/rates/presentation/manager/rates_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';

class RatesPageContent extends StatefulWidget {
  const RatesPageContent({Key? key}) : super(key: key);

  @override
  _RatesPageContentState createState() => _RatesPageContentState();
}

class _RatesPageContentState extends State<RatesPageContent> {
  @override
  void initState() {
    RatesViewModel viewModel=sl();
    viewModel.onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
  

    Timer(Duration(milliseconds: 400),(){
      viewModel.resetFields();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: context.read<RatesViewModel>().ratesFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Get Best Rate\'s', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 34.h),
                MultiValueListenableBuilder(
                  valueListenables: [
                    context.read<RatesViewModel>().prefixIconPathNotifier,
                    context.read<RatesViewModel>().networkPrefixNotifier,
                  ],
                  builder: (_, values, __) {
                    return CustomTextFormField(
                      maxLines: 1,
                      readOnly: true,
                      prefixIconPath: values.elementAt(0),
                      networkPrefix: values.elementAt(1),
                      keyboardType: TextInputType.number,
                      labelText: context.read<RatesViewModel>().destinationCountryLabelText,
                      hintText: context.read<RatesViewModel>().destinationCountryHintText,
                      controller: context.read<RatesViewModel>().destinationCountryController,
                      validator: context.read<RatesViewModel>().validateCountry,
                      focusNode: context.read<RatesViewModel>().destinationCountryFocusNode,
                      suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                      onTap: () async {
                        RateListBottomSheet bottomSheet = RateListBottomSheet(context);
                        context.read<RatesViewModel>().getRateList();
                        await bottomSheet.show();
                      },
                    );
                  },
                ),
                SizedBox(height: 22.h),
                CustomTextFormField(
                  maxLines: 1,
                  prefixIconPath: AppAssets.icMoneySvg,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  labelText: context.read<RatesViewModel>().sendMoneyLabelText,
                  hintText: context.read<RatesViewModel>().sendMoneyHintText,
                  controller: context.read<RatesViewModel>().sendMoneyController,
                  focusNode: context.read<RatesViewModel>().sendMoneyFocusNode,
                  validator: context.read<RatesViewModel>().validateAmount,
                  onFieldSubmitted: (_) => context.read<RatesViewModel>().onSendMoneySubmitted(context),
                  suffix: Text('AUD', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                  onChanged: context.read<RatesViewModel>().onSendMoneyChange,
                ),
                SizedBox(height: 22.h),
                ValueListenableBuilder<String>(
                  valueListenable: context.read<RatesViewModel>().destinationNationCurrencyNotifier,
                  builder: (_, value, __) {
                    return CustomTextFormField(
                      maxLines: 1,
                      readOnly: true,
                      prefixIconPath: AppAssets.icMoneySvg,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      labelText: context.read<RatesViewModel>().receivedMoneyLabelText,
                      hintText: context.read<RatesViewModel>().receivedMoneyHintText,
                      controller: context.read<RatesViewModel>().receivedMoneyController,
                      focusNode: context.read<RatesViewModel>().receivedMoneyFocusNode,
                      suffix: Text(value, style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                    );
                  },
                ),
                SizedBox(height: 22.h),
                ValueListenableBuilder(
                  valueListenable: context.read<RatesViewModel>().exchangeRateNotifier,
                  builder: (_, value, __) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text('Exchange Rate: $value', style: Theme.of(context).textTheme.subtitle2),
                    );
                  },
                ),
                // TextButton(
                //     onPressed: () {
                //       context.read<RatesViewModel>().getRateList();
                //     },
                //     child: Text('as')),
                SizedBox(height: 22.h),
                ContinueButton(
                  text: 'Send',
                  loadingNotifier: context.read<RatesViewModel>().isLoadingNotifier,
                  isEnabledNotifier: context.read<RatesViewModel>().sendEnabledNotifier,
                  onPressed: () {
                    if (context.read<RatesViewModel>().ratesFormKey.currentState!.validate()) {
                      context.read<RatesViewModel>().send();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
