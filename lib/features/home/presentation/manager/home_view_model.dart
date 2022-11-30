import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uremit/app/models/profile_header_request_model.dart';
import 'package:uremit/app/models/profile_header_response_model.dart';
import 'package:uremit/app/usecases/profile_header_usecase.dart';
import 'package:uremit/features/home/models/get_profile_admin_approval_response_model.dart';
import 'package:uremit/features/home/models/get_profile_admin_approvel_request_model.dart';
import 'package:uremit/services/models/on_error_message_model.dart';
import 'package:uremit/utils/constants/enums/page_state_enum.dart';
import 'package:uremit/utils/router/models/page_action.dart';

import '../../../../app/globals.dart';
import '../../../../app/providers/account_provider.dart';
import '../../../../services/error/failure.dart';
import '../../../../utils/constants/enums/attachment_type.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/router/models/page_config.dart';
import '../../../cards/presentation/pages/cards_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../receivers/presentation/manager/receiver_view_model.dart';
import '../../../receivers/presentation/pages/receiver_page.dart';
import '../../models/profile_image_request_model.dart';
import '../../usecases/get_profile_admin_approvel_usecase.dart';
import '../../usecases/profile_image_usecase.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(
      {required this.profileHeaderUsecase,
      required this.profileImageUsecase,
      required this.getProfileAdminApprovelUsecase});

  // Usecases
  ProfileHeaderUsecase profileHeaderUsecase;
  GetProfileAdminApprovelUsecase getProfileAdminApprovelUsecase;
  ProfileImageUsecase profileImageUsecase;
  // Value Notifiers
  ValueChanged<OnErrorMessageModel>? onErrorMessage;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);
  ValueNotifier<int> pageIndex = ValueNotifier(0);
  ValueNotifier<bool> fabClicked = ValueNotifier(false);
  ValueNotifier<List<ProfileHeaderBody>> profileDetailsNotifier =
      ValueNotifier([]);

  // Properties
  PageController pageController = PageController();
  GetProfileAdminApprovelResponseModel? getProfileAdminApprovalResponseModel;

  final pages = const [
    DashboardPage(),
    ReceiverPage(),
    CardsPage(),
  ];

  ProfileHeaderResponseModel? profileHeader;

  // Getters
  AppState appState = GetIt.I.get<AppState>();
  AccountProvider get _accountProvider => sl();

  // Usecase Calls
  Future<void> getProfileHeader({bool recall = false}) async {
    if (recall == false) {
      if (profileHeader != null) {
        return;
      }
    }

    print('[GET-PROFILE-HEADER]');

    isLoadingNotifier.value = true;

    ProfileHeaderRequestModel params = ProfileHeaderRequestModel(
        userId: _accountProvider.userDetails!.userDetails.id);

    var profileHeaderEither = await profileHeaderUsecase.call(params);

    if (profileHeaderEither.isLeft()) {
      handleError(profileHeaderEither);
      isLoadingNotifier.value = false;
    } else if (profileHeaderEither.isRight()) {
      profileHeaderEither.foldRight(null, (response, _) {
        profileHeader = response;
      });
      isLoadingNotifier.value = false;
    }
  }

  Future<void> getProfileAdminApprovel() async {
    GetProfileAdminApprovelRequestModel params =
        GetProfileAdminApprovelRequestModel(
            id: _accountProvider.userDetails!.userDetails.id);

    var profileHeaderEither = await getProfileAdminApprovelUsecase.call(params);

    if (profileHeaderEither.isLeft()) {
      handleError(profileHeaderEither);
    } else if (profileHeaderEither.isRight()) {
      profileHeaderEither.foldRight(null, (response, _) {
        getProfileAdminApprovalResponseModel = response;
      });
    }
  }

  clearData() {
    profileHeader = null;
  }

  ValueNotifier<bool> profileImageNotifier = ValueNotifier(false);
  Future<void> setProfileImage(BuildContext context) async {
    var params = ProfileImageRequestModel(
        userId: _accountProvider.userDetails!.userDetails.id.toString(),
        image: profileImg.toString());

    var updateEither = await profileImageUsecase(params);

    if (updateEither.isLeft()) {
      profileImageNotifier.value = false;

      handleError(updateEither);
    } else if (updateEither.isRight()) {
      updateEither.foldRight(null, (response, previous) {
        updateEither.foldRight(null, (response, _) async {
          Fluttertoast.showToast(
              msg: 'Updated',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 12.0);
          HomeViewModel homeViewModel = sl();
          await homeViewModel.getProfileHeader(recall: true);
          profileImgFile.value = null;

          // onErrorMessage?.call(OnErrorMessageModel(message: 'Updated', backgroundColor: Colors.green));
        });
        profileImageNotifier.value = false;
      });
      profileImageNotifier.value = false;
    }
  }

  // List<PlatformFile> paths = [];
  XFile? selectedFile;
  String? profileImg = '';
  ValueNotifier<File?> profileImgFile = ValueNotifier(null);
  final TextEditingController profileImgController = TextEditingController();
  String profileImgId = '';
  // Methods
  Future<void> pickFiles(
      BuildContext context, AttachmentType type, String source) async {
    selectedFile = null;

    try {
      switch (source) {
        case 'camera':
          selectedFile = (await ImagePicker()
              .pickImage(source: ImageSource.camera, imageQuality: 50));
          break;
        case 'gallery':
          selectedFile = (await ImagePicker()
              .pickImage(source: ImageSource.gallery, imageQuality: 50));
          break;
      }

      if (selectedFile != null) {
        profileImgFile.value = File(selectedFile!.path);
        String? base64 = encodeToBase64(profileImgFile.value);
        if (base64 != null) {
          switch (type) {
            case AttachmentType.profileImage:
              profileImg = base64;
              profileImgController.text =
                  profileImgFile.value!.path.split('/').last;
              print('this is the name of the pic ${profileImgController.text}');
              break;
          }
        }
      }
    } on PlatformException catch (e) {
      onErrorMessage?.call(OnErrorMessageModel(message: e.message.toString()));
    } catch (e) {
      onErrorMessage?.call(OnErrorMessageModel(message: e.toString()));
    }
  }

  Future<void> profileImageSelector(context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: 150,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: Colors.orange,
                    ),
                    title: const Text('Camera'),
                    onTap: () async {
                      await pickFiles(
                          context, AttachmentType.profileImage, 'camera');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.orange,
                      ),
                      title: const Text('Pick From Gallery'),
                      onTap: () async {
                        await pickFiles(
                            context, AttachmentType.profileImage, 'gallery');
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  String? encodeToBase64(File? file) {
    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      return base64Encode(imageBytes);
    }
    return null;
  }

  void onBottomNavTap(int index) {
    fabClicked.value = false;
    pageIndex.value = index;
    if (index > 1) {
      pageController.animateToPage(index + 1,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    } else {
      pageController.animateToPage(index,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    }
  }

  void onFabTap() {
    ReceiverViewModel receiverViewModel = sl();
    receiverViewModel.isPaymentReceiver = true;
    AppState appState = sl();
    appState.currentAction = PageAction(
        state: PageState.addPage, page: PageConfigs.paymentWrapperPageConfig);
    fabClicked.value = true;
    Timer(const Duration(milliseconds: 400), () {
      fabClicked.value = false;
    });
    // pageIndex.value = -1;
    // pageController.animateToPage(2, duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    isLoadingNotifier.value = false;
    either.fold(
        (l) => onErrorMessage?.call(OnErrorMessageModel(message: l.message)),
        (r) => null);
  }

  // Page Moves
  void moveToAuthWrapperPage() {
    Timer(const Duration(seconds: 5), () {
      appState.currentAction = PageAction(
          state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);
    });
  }
}
