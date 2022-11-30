import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';

import '../../../features/payment/receiver_info/models/get_uremit_banks_countires_response_model.dart';
import '../../../features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';
import '../../../features/receivers/models/get_bank_list_response_model.dart';
import '../customs/custom_form_field.dart';

class GetReceiverBanksListBottomSheet {
  final BuildContext context;
  final GetUremitBanksCountriesResponseModelBody country;

  GetReceiverBanksListBottomSheet(this.context, this.country);
  ValueNotifier<List<GetBankListResponseModelBody>> banks = ValueNotifier([]);

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            height: 400.h+EdgeInsets.fromWindowPadding(
                WidgetsBinding.instance.window.viewInsets,
                WidgetsBinding
                    .instance.window.devicePixelRatio)
                .bottom,
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
                Text('Add Bank', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 3.h),
                Text('Select receiver bank',
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context
                        .read<ReceiverInfoViewModel>()
                        .isBanksListLoadingNotifier,
                    builder: (_, isLoading, __) {
                      if (!isLoading && banks.value.isEmpty) {
                        banks.value = context
                            .read<ReceiverInfoViewModel>()
                            .getBanks!
                            .getBankListResponseModelBody;
                      }
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
                            : Column(
                                children: [
                                  CustomTextFormField(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 4),
                                    hintText: 'Search',
                                    labelText: 'Search',
                                    onChanged: (value) {
                                      banks.value = context
                                          .read<ReceiverInfoViewModel>()
                                          .getBanks!
                                          .getBankListResponseModelBody
                                          .where((element) => element.name
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    },
                                  ),
                                  Expanded(
                                    child: ValueListenableBuilder<
                                            List<GetBankListResponseModelBody>>(
                                        valueListenable: banks,
                                        builder: (_, banksList, __) {
                                          if (banksList.isEmpty) {
                                            return const Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text('No bank found'),
                                            );
                                          }
                                          return ListView.separated(
                                            itemCount: banksList.length ,
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Divider(
                                                  thickness: 0.8,
                                                  color: Colors.grey
                                                      .withOpacity(0.8));
                                            },
                                            itemBuilder: (_, index) {
                                              return ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: ClipOval(
                                                  child: SizedBox(
                                                    width: 40.w,
                                                    height: 40.w,
                                                    child: SvgPicture.asset(
                                                      AppAssets
                                                          .icDocumentTypeSvg,
                                                      width: 40.w,
                                                      height: 40.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                    banksList[index].name ,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2),
                                                subtitle: Text(
                                                    country.countryName
                                                        .toUpperCase(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption),
                                                onTap: () {

                                                  context
                                                      .read<
                                                          ReceiverInfoViewModel>()
                                                      .bankController
                                                      .text = banksList[index]
                                                          .name ;

                                                  context
                                                      .read<
                                                          ReceiverInfoViewModel>()
                                                      .bankId = banksList[
                                                          index]
                                                      .bankId
                                                      .toString();
                                                  print(
                                                      'this is the bank id ${context.read<ReceiverInfoViewModel>().bankId}');
                                                  context
                                                          .read<
                                                              ReceiverInfoViewModel>()
                                                          .getBankListResponseModelBody =
                                                      banksList[index];
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                ],
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
