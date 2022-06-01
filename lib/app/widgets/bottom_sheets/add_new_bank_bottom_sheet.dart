import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/app/widgets/bottom_sheets/get_banks_edit_receiver_bottom_sheet.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/router/uremit_router_delegate.dart';

import '../../../utils/constants/app_level/app_assets.dart';
import '../customs/custom_form_field.dart';

class AddBankBottomSheet {
  final BuildContext context;
  final bool isDeleteReceiver;
  ReceiverViewModel viewModel = sl();
  String countryId;

  AddBankBottomSheet({required this.context, required this.isDeleteReceiver, required this.countryId});

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return FractionallySizedBox(
          heightFactor: .8,
          child: SafeArea(
            child: ChangeNotifierProvider.value(
              value: viewModel,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
                ),
                padding: EdgeInsets.only(top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
                child: Form(
                  key: context.read<ReceiverViewModel>().addReceiverBankFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add Receiver Bank', style: Theme.of(context).textTheme.headline6),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          maxLines: 1,
                          readOnly: true,
                          prefixIconPath: AppAssets.icBankSvg,
                          keyboardType: TextInputType.name,
                          labelText: context.read<ReceiverViewModel>().bankLabelText,
                          hintText: context.read<ReceiverViewModel>().bankHintText,
                          controller: context.read<ReceiverViewModel>().bankController,
                          focusNode: context.read<ReceiverViewModel>().bankFocusNode,
                          suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
                          validator: context.read<ReceiverViewModel>().validateBank,
                          onChanged: context.read<ReceiverViewModel>().onEmailChange,
                          onFieldSubmitted: (_) => context.read<ReceiverViewModel>().onBankSubmitted(context),
                          onTap: () async {
                            context.read<ReceiverViewModel>().getBanksList(countryId);
                            GetBankEditReceiverBottomSheet _bottomSheet = GetBankEditReceiverBottomSheet(context, countryId);
                            await _bottomSheet.show();
                          },
                        ),
                        SizedBox(height: 16.h),
                        InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Select Type',
                          ),
                          child: RadioGroup(
                            controller: context.read<ReceiverViewModel>().accountTypeController,
                            values: context.read<ReceiverViewModel>().accountTypeValues,
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
                          labelText: context.read<ReceiverViewModel>().accountNumberLabelText,
                          hintText: context.read<ReceiverViewModel>().accountNumberHintText,
                          validator: context.read<ReceiverViewModel>().validateAccountNumber,
                          controller: context.read<ReceiverViewModel>().accountNumberController,
                          focusNode: context.read<ReceiverViewModel>().accountNumberFocusNode,
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
                                labelText: context.read<ReceiverViewModel>().accountHolderNameLabelText,
                                hintText: context.read<ReceiverViewModel>().accountHolderNameHintText,
                                controller: context.read<ReceiverViewModel>().accountHolderNameController,
                                focusNode: context.read<ReceiverViewModel>().accountHolderNameFocusNode,
                                onTap: () async {},
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ValueListenableBuilder<bool>(
                            valueListenable: context.read<ReceiverViewModel>().status,
                            builder: (_, value, __) {
                              return !value
                                  ? SizedBox.shrink()
                                  : ContinueButton(
                                      text: 'Save',
                                      onPressed: () async {
                                        context.read<ReceiverViewModel>().addReceiverBankFormKey.currentState!.validate();
                                      },
                                    );
                            }),
                        SizedBox(height: 16.h),
                        ContinueButton(
                          loadingNotifier: context.read<ReceiverViewModel>().isLoadingNotifier,
                          text: 'Save',
                          onPressed: () async {},
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
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      globalHomeContext = null;
    });
  }
}
