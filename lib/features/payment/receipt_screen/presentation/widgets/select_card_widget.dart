import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/select_bank_bottom_sheet.dart';

import '../../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../../utils/constants/app_level/app_assets.dart';
import '../../../../cards/presentation/manager/cards_view_model.dart';

class SelectCardWidget extends StatefulWidget {
  const SelectCardWidget({Key? key}) : super(key: key);

  @override
  State<SelectCardWidget> createState() => _SelectCardWidgetState();
}

class _SelectCardWidgetState extends State<SelectCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      child: CustomTextFormField(
        maxLines: 1,
        readOnly: true,
        prefixIconPath: AppAssets.icCardSvg,
        keyboardType: TextInputType.name,
        labelText: 'Select Card',
        hintText: '',
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        controller: context.read<CardsViewModel>().cardController,
        focusNode: context.read<CardsViewModel>().receiverCountryFocusNode,
        suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).canvasColor),
        onTap: () async {
          SelectCardBottomSheet bottomSheet = SelectCardBottomSheet(context);

          await bottomSheet.show();
        },
      ),
    );
  }
}
