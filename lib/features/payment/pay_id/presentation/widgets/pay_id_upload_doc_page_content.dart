import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/payment/pay_id/presentation/manager/pay_id_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/widgets/customs/continue_button.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../../utils/constants/enums/attachment_type.dart';

class PayIdUploadDocumentsPageContent extends StatefulWidget {
  const PayIdUploadDocumentsPageContent({Key? key}) : super(key: key);

  @override
  _PayIdUploadDocumentsPageContentState createState() => _PayIdUploadDocumentsPageContentState();
}

class _PayIdUploadDocumentsPageContentState extends State<PayIdUploadDocumentsPageContent> {
  @override
  void initState() {
    context.read<PayIdInfoViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    Timer(Duration(milliseconds: 300), () {
      context.read<PayIdInfoViewModel>().selectedFile.value = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptScreenViewModel>(builder: (context, provider, ch) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: provider.fromChangePaymentMethod
            ? CustomAppBar(title: provider.updateTransaction!.paymentGateway == 'Manual Bank Transfer' ? 'Bank Transfer' : 'PayID Transfer')
            : CustomAppBar(title: context.read<ReceiptScreenViewModel>().selectedPaymentMethod.value!.id == 0 ? 'Bank Transfer' : 'PayID Transfer'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h, width: double.infinity),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Upload the Required File', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)),
              ),
            ),
            SizedBox(height: 22.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(22.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('File Upload', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black)),
                      ),
                      SizedBox(height: 26.h),
                      GestureDetector(
                        onTap: () {
                          context.read<PayIdInfoViewModel>().docsImageSelector(context, AttachmentType.payIdDoc);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            labelText: 'PayID Document',
                            labelStyle: TextStyle(color: Colors.black),
                            floatingLabelAlignment: FloatingLabelAlignment.center,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: SizedBox(
                              height: 200.h,
                              child: ValueListenableBuilder<File?>(
                                  valueListenable: context.read<PayIdInfoViewModel>().selectedFile,
                                  builder: (_, file, __) {
                                    if (file != null) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(50.r),
                                            child: Image.file(
                                              file,
                                              fit: BoxFit.cover,
                                            )),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          SizedBox(height: 5.h),
                                          SvgPicture.asset(
                                            AppAssets.icPlaceHolderFileSvg,
                                            height: 120.h,
                                          ),
                                          Text(
                                            'File Not Available',
                                            style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey),
                                          ),
                                          const Spacer(),
                                          Container(
                                            color: Colors.grey,
                                            height: 40.h,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Choose Attachment',
                                              style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      ContinueButton(
                        loadingNotifier: context.read<PayIdInfoViewModel>().isLoadingNotifier,
                        text: 'Next',
                        onPressed: () async {
                          if (context.read<PayIdInfoViewModel>().selectedFile.value == null) {
                            return context.show(message: 'Document file not selected');
                          }
                          context.read<PayIdInfoViewModel>().insertPaymentProof();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
