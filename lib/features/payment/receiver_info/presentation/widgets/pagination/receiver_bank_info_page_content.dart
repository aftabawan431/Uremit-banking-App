import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../../../../app/widgets/bottom_sheets/get_receiver_banks_list_bottom_sheet.dart';
import '../../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../../utils/constants/app_level/app_assets.dart';
import '../../manager/receiver_info_view_model.dart';

class ReceiverBankInfo extends StatelessWidget {
  const ReceiverBankInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: Form(
        key: context.read<ReceiverInfoViewModel>().receiverBankInfoFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Receiver Info', style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 16.h),
              CustomTextFormField(
                maxLines: 1,
                readOnly: true,
                prefixIconPath: AppAssets.icBankSvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().bankLabelText,
                hintText: context.read<ReceiverInfoViewModel>().bankHintText,
                controller: context.read<ReceiverInfoViewModel>().bankController,
                focusNode: context.read<ReceiverInfoViewModel>().bankFocusNode,
                suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                validator: context.read<ReceiverInfoViewModel>().validateBank,
                onChanged: context.read<ReceiverInfoViewModel>().onEmailChange,
                onFieldSubmitted: (_) => context.read<ReceiverInfoViewModel>().onBankSubmitted(context),
                onTap: () async {
                  GetReceiverBanksListBottomSheet _bottomSheet = GetReceiverBanksListBottomSheet(context, context.read<ReceiverInfoViewModel>().receiverCountry!);
                  await _bottomSheet.show();
                },
              ),
              SizedBox(height: 16.h),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Select Type',
                ),
                child: RadioGroup(
                  controller: context.read<ReceiverInfoViewModel>().accountTypeController,
                  values: context.read<ReceiverInfoViewModel>().accountTypeValues,
                  indexOfDefault: 0,
                  orientation: RadioGroupOrientation.Horizontal,
                  decoration: RadioGroupDecoration(
                    labelStyle: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12.sp),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                maxLines: 1,
                prefixIconPath: AppAssets.icDocumentNumberSvg,
                keyboardType: TextInputType.name,
                labelText: context.read<ReceiverInfoViewModel>().accountNumberLabelText,
                hintText: context.read<ReceiverInfoViewModel>().accountNumberHintText,
                validator: context.read<ReceiverInfoViewModel>().validateAccountNumber,
                controller: context.read<ReceiverInfoViewModel>().accountNumberController,
                focusNode: context.read<ReceiverInfoViewModel>().accountNumberFocusNode,
                onTap: () async {},
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      child: Container(
                          height: 40.h,
                          width: 140.w,
                          child: const Center(
                              child: Text(
                            'Validate',
                          )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.amber,
                            boxShadow: const [
                              BoxShadow(color: Colors.amber, spreadRadius: 3),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SimpleShadow(
                opacity: 0.2,
                color: Colors.black12,
                offset: const Offset(0, 0),
                sigma: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FCFF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  height: 100.h,
                  child: Center(
                    child: CustomTextFormField(
                      maxLines: 1,
                      prefixIconPath: AppAssets.icAccountHolderSvg,
                      keyboardType: TextInputType.name,
                      labelText: context.read<ReceiverInfoViewModel>().accountHolderNameLabelText,
                      hintText: context.read<ReceiverInfoViewModel>().accountHolderNameHintText,
                      controller: context.read<ReceiverInfoViewModel>().accountHolderNameController,
                      focusNode: context.read<ReceiverInfoViewModel>().accountHolderNameFocusNode,
                      onTap: () async {},
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ValueListenableBuilder<bool>(
                  valueListenable: context.read<ReceiverInfoViewModel>().status,
                  builder: (_, value, __) {
                    return !value
                        ? const SizedBox.shrink()
                        : ContinueButton(
                            text: 'Save',
                            onPressed: () async {
                              context.read<ReceiverInfoViewModel>().receiverBankInfoFormKey.currentState!.validate();
                              context.read<ReceiverInfoViewModel>().addReceiver(context, hasBank: true);
                            },
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
