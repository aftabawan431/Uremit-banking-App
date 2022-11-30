import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/summary_reciept_details.dart';
import 'package:uremit/features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import 'package:uremit/utils/router/models/page_config.dart';

import '../../../../../app/widgets/clippers/receipt_details_clipper.dart';
import '../../../../../utils/router/app_state.dart';

class SummaryDetailsScreenPageContent extends StatefulWidget {
  const SummaryDetailsScreenPageContent({Key? key}) : super(key: key);

  @override
  _SummaryDetailsScreenPageContentState createState() =>
      _SummaryDetailsScreenPageContentState();
}

class _SummaryDetailsScreenPageContentState
    extends State<SummaryDetailsScreenPageContent> {
  ScreenshotController screenshotController = ScreenshotController();

  PaymentDetailsViewModel paymentDetailsViewModel = sl();
  ReceiptScreenViewModel receiptScreenViewModel = sl();
  ReceiverViewModel receiverViewModel = sl();
  ReceiverInfoViewModel receiverInfoViewModel = sl();
  HomeViewModel homeViewModel = sl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppState appState = sl();
    Timer(Duration(milliseconds: 300), () {
      appState.removePage(PageConfigs.paymentWrapperPageConfig);
    });
    // Timer(Duration(seconds: 3),(){
    //   paymentDetailsViewModel.clearAllTextFields();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    Timer(const Duration(milliseconds: 100), () {
      paymentDetailsViewModel.clearAllTextFields();
    });
  }

  downloadTap() async {
    screenshotController.capture().then((Uint8List? image) async {
      final res = await Permission.storage.status;
      if (res == PermissionStatus.permanentlyDenied) {
        return context.show(
            message:

                'Storage permission is permanently denied please allow from setting',
            backgroundColor: Colors.red);
      } else if (res == PermissionStatus.denied) {
        final response = await Permission.storage.request();
        if (response != PermissionStatus.granted) {
          return context.show(
              message: 'Please allow permission to download image',
              backgroundColor: Colors.red);
        }
      }

      final result = await ImageGallerySaver.saveImage(image!,
          quality: 80, name: DateTime.now().toString());
      Logger().v(result);

      if (result['isSuccess']) {
        context.show(message: 'Receipt Saved', backgroundColor: Colors.green);
        Logger().v(result);
      } else {
        context.show(
            message: "Receipt couldn't be saved.", backgroundColor: Colors.red);

        Logger().v(result);
      }

      return;
    }).catchError((onError) {
      Logger().v('Eror');
      print(onError);
    });
  }

  shareTap() async {
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }

      return;
      Directory? directory;
      Uint8List? _imageFile;

      //Capture Done
      _imageFile = image;
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();
        String newPath = '';

        List<String> paths = directory!.path.split('/');
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != 'Android') {
            newPath += '/' + folder;
          } else {
            break;
          }
        }
        newPath = newPath + '/Uremit';
        directory = Directory(newPath);
        File saveFile = File(directory.path + '/summary.jpg');

        await saveFile.writeAsBytes(image!);
        await Share.shareFiles(
          [saveFile.path],
          text: 'Summary',
          subject: 'Uremit',
        );
      } else {
        // await Permission.storage.request();
        print('no permissions');
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: paymentDetailsViewModel),
        ChangeNotifierProvider.value(value: receiptScreenViewModel),
        ChangeNotifierProvider.value(value: receiverViewModel),
        ChangeNotifierProvider.value(value: receiverInfoViewModel),
        ChangeNotifierProvider.value(value: homeViewModel),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: 'Summary'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Screenshot(
                controller: screenshotController,
                child: Padding(
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
                          const SummaryReceiptDetails(),
                          // const UpdatePendingTransaction(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: downloadTap,
                        child: Container(
                          height: 40.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              'Download',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: shareTap,
                        child: Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              'Share',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    GetIt.I.get<AppState>().moveToBackScreen();

                    // context.show(message: 'Your request is in Process');
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
                        'Done',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
