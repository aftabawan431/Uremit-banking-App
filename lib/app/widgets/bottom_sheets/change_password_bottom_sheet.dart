import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/continue_button.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';

import '../../../features/menu/security/presentation/manager/security_view_model.dart';
import '../customs/custom_form_field.dart';

class ChangePasswordBottomSheet {
  final BuildContext context;

  ChangePasswordBottomSheet({required this.context});

  Future show() async {
    context.read<SecurityViewModel>().isPasswordIncorrect.value = false;
    context.read<SecurityViewModel>().oldPasswordController.clear();
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return Padding(
          padding: MediaQuery.of(bottomSheetContext).viewInsets,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
              ),
              padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 22.w),
              child: Form(
                key: context.read<SecurityViewModel>().formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: context.read<SecurityViewModel>().isPasswordIncorrect,
                          builder: (_, value, __) {
                            if (value) {
                              return SvgPicture.asset(AppAssets.icWarningSvg, width: 48.w);
                            } else {
                              return SvgPicture.asset(AppAssets.icPasswordSvg, color: Colors.orange, width: 48.w);
                            }
                          },
                        ),
                        SizedBox(width: 5.w),
                        Text('Old Password', style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: context.read<SecurityViewModel>().isPasswordIncorrect,
                      builder: (_, value, __) {
                        if (!value) {
                          return Text('Enter Old Password', style: Theme.of(context).textTheme.bodyText2);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: context.read<SecurityViewModel>().obsecureTextNotifier,
                      builder: (_, obsecureText, __) {
                        return CustomTextFormField(
                          maxLines: 1,
                          obscureText: obsecureText,
                          prefixIconPath: AppAssets.icPasswordSvg,
                          suffixIconPath: obsecureText ? AppAssets.icEyeClosedSvg : AppAssets.icEyeOpenSvg,
                          labelText: context.read<SecurityViewModel>().oldPasswordLabelText,
                          hintText: context.read<SecurityViewModel>().oldPasswordHintText,
                          controller: context.read<SecurityViewModel>().oldPasswordController,
                          focusNode: context.read<SecurityViewModel>().oldPasswordFocusNode,
                          onFieldSubmitted: (_) => context.read<SecurityViewModel>().onPasswordSubmitted(context),
                          suffixIconOnTap: context.read<SecurityViewModel>().onObsecureChange,
                          validator: context.read<SecurityViewModel>().validateOldPassword,
                          onChanged: context.read<SecurityViewModel>().onOldPasswordChange,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    ContinueButton(
                      text: 'Save',
                      loadingNotifier: context.read<SecurityViewModel>().isLoadingNotifier,
                      onPressed: () async {
                        context.read<SecurityViewModel>().isSaveButtonPressed = true;
                        if (!context.read<SecurityViewModel>().formKey.currentState!.validate()) {
                          return;
                        }
                        await context.read<SecurityViewModel>().changePassword(bottomSheetContext);
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
