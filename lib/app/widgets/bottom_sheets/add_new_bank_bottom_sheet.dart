import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/app/widgets/bottom_sheets/get_banks_edit_receiver_bottom_sheet.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../utils/constants/app_level/app_assets.dart';
import '../../../utils/router/uremit_router_delegate.dart';
import '../customs/custom_form_field.dart';

class AddBankBottomSheet {
  final BuildContext context;
  final bool isDeleteReceiver;
  ReceiverViewModel viewModel = sl();
  String countryId;
  String receiverId;
  String countryName;

  AddBankBottomSheet({required this.context, required this.receiverId, required this.countryName, required this.isDeleteReceiver, required this.countryId});

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return FractionallySizedBox(
          heightFactor: .8,
          child: Scaffold(
            body : ChangeNotifierProvider.value(
              value: viewModel,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
                  ),
                  padding: EdgeInsets.only(top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                          key: context.read<ReceiverViewModel>().receiverBankInfoFormKey,
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
                                  GetBankEditReceiverBottomSheet _bottomSheet = GetBankEditReceiverBottomSheet(
                                    context,
                                    countryId,
                                    countryName,
                                  );
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
                                onTap: () async {
                                  context.read<ReceiverViewModel>().accountHolderNameController.clear();
                                },
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ValueListenableBuilder<bool>(
                                      valueListenable: context.read<ReceiverViewModel>().isValidateLoadingNotifier,
                                      builder: (_, value, __) {
                                        return value
                                            ? const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40),
                                                child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());

                                                  // context.read<ReceiverViewModel>().isReceiverInfoPageChange = true;

                                                  // Logger().i(context.read<ReceiverViewModel>().isReceiverInfoPageChange);
                                                  if (!context.read<ReceiverViewModel>().receiverBankInfoFormKey.currentState!.validate()) {
                                                    return;
                                                  }
                                                  context.read<ReceiverViewModel>().validateUserBank(context);
                                                },
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
                                              );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Form(
                            key: context.read<ReceiverViewModel>().addReceiverBankFormKey,
                            child: Column(
                              children: [
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
                                        enabled: false,
                                        maxLines: 1,
                                        prefixIconPath: AppAssets.icAccountHolderSvg,
                                        keyboardType: TextInputType.name,
                                        labelText: context.read<ReceiverViewModel>().accountHolderNameLabelText,
                                        hintText: context.read<ReceiverViewModel>().accountHolderNameHintText,
                                        controller: context.read<ReceiverViewModel>().accountHolderNameController,
                                        focusNode: context.read<ReceiverViewModel>().accountHolderNameFocusNode,
                                        validator: context.read<ReceiverViewModel>().validateAccountNumber,
                                        onTap: () async {},
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ContinueButton(
                                  loadingNotifier: context.read<ReceiverViewModel>().isLoadingNotifier,
                                  text: 'Save',
                                  onPressed: () async {
                                    print(context.read<ReceiverViewModel>().addReceiverBankFormKey.currentState!.validate());
                                    if (context.read<ReceiverViewModel>().accountHolderNameController.text == '') {
                                      Fluttertoast.showToast(
                                          msg: 'Please Validate Bank',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 12.sp);
                                      return;
                                    }
                                    // if (!context.read<ReceiverViewModel>().addReceiverBankFormKey.currentState!.validate()) {
                                    //   return;
                                    // }
                                    await context.read<ReceiverViewModel>().addBank(context, receiverId);
                                    Navigator.of(context).pop();
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
                            ))
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
