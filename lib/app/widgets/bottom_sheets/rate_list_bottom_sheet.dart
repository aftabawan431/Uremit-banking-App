import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/rates/presentation/manager/rates_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

class RateListBottomSheet {
  final BuildContext context;

  RateListBottomSheet(this.context);

  Future show() async {
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
                Text('Select country to check the exchange rate', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: context.read<RatesViewModel>().isLoadingNotifier,
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
                                itemCount: context.read<RatesViewModel>().rateList?.rateListBody.length ?? 0,
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
                                          AppUrl.fileBaseUrl + context.read<RatesViewModel>().rateList!.rateListBody[index].country.svgPath,
                                          width: 40.w,
                                          height: 40.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(context.read<RatesViewModel>().rateList?.rateListBody[index].country.name ?? '', style: Theme.of(context).textTheme.bodyText2),
                                    subtitle: Text('Exchange Rate: ${context.read<RatesViewModel>().rateList?.rateListBody[index].exchangeRate ?? ''}',
                                        style: Theme.of(context).textTheme.caption),
                                    trailing: context.read<RatesViewModel>().selectedCountryIndex == index ? Icon(Icons.done_rounded, color: Theme.of(context).primaryColor) : null,
                                    onTap: () {
                                      context.read<RatesViewModel>().selectedCountryIndex = index;

                                      context.read<RatesViewModel>().prefixIconPathNotifier.value =
                                          AppUrl.fileBaseUrl + context.read<RatesViewModel>().rateList!.rateListBody[index].country.svgPath;
                                      context.read<RatesViewModel>().networkPrefixNotifier.value = true;

                                      context.read<RatesViewModel>().receivedMoneyController.text = '';
                                      context.read<RatesViewModel>().sendMoneyController.text = '';

                                      context.read<RatesViewModel>().destinationCountryController.text =
                                          context.read<RatesViewModel>().rateList?.rateListBody[index].country.name ?? '';

                                      context.read<RatesViewModel>().exchangeRateNotifier.value =
                                          '${context.read<RatesViewModel>().rateList?.rateListBody[index].exchangeRate.toStringAsFixed(2) ?? ''} ${context.read<RatesViewModel>().rateList?.rateListBody[index].country.currency.toUpperCase()}';

                                      context.read<RatesViewModel>().destinationNationCurrencyNotifier.value =
                                          context.read<RatesViewModel>().rateList?.rateListBody[index].country.currency.toUpperCase() ?? '';

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
