import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

import '../../../features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';

class ReceiverInfoCountriesBottomSheet {
  final BuildContext context;
  final int type;

  ReceiverInfoCountriesBottomSheet({required this.context, required this.type});

  Future show() async {
    String typeStr = '';
    switch (type) {
      case 0:
        typeStr = 'receiver country';
        break;
    }
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
                Text('Select Country', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 3.h),
                Text('Select country of $typeStr', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context.read<ReceiverInfoViewModel>().isCountryLoadingNotifier,
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
                                itemCount: context.read<ReceiverInfoViewModel>().countriesList?.body.length ?? 0,
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
                                        child: SvgPicture.network(
                                          AppUrl.fileBaseUrl + context.read<ReceiverInfoViewModel>().countriesList!.body[index].svgPath,
                                          width: 40.w,
                                          height: 40.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(context.read<ReceiverInfoViewModel>().countriesList?.body[index].countryName ?? '', style: Theme.of(context).textTheme.bodyText2),
                                    onTap: () {
                                      print(context.read<ReceiverInfoViewModel>().countriesList);
                                      if (type == 0) {
                                        context.read<ReceiverInfoViewModel>().bankController.text = '';
                                        context.read<ReceiverInfoViewModel>().countryId =context.read<ReceiverInfoViewModel>().countriesList?.body[index].countryId??'';

                                        context.read<ReceiverInfoViewModel>().receiverCountryController.text =
                                            context.read<ReceiverInfoViewModel>().countriesList?.body[index].countryName ?? '';
                                        context.read<ReceiverInfoViewModel>().receiverCountry = context.read<ReceiverInfoViewModel>().countriesList?.body[index];
                                        context.read<ReceiverInfoViewModel>().getBanksList(context.read<ReceiverInfoViewModel>().countriesList?.body[index].countryId ?? '-1');
                                      }
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
