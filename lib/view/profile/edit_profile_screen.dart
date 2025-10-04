import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/constant/enum/form_type.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/services/user_services.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/firebase_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_dropdown.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.userID});

  final String userID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(
        userRepository: UserRepository(
          sharedPreferenceHandler: SharedPreferenceHandler(),
          userServices: UserServices(),
        ),
      ),
      child: _EditProfileScreen(userID: userID),
    );
  }
}

class _EditProfileScreen extends BaseStatefulPage {
  const _EditProfileScreen({required this.userID});

  final String userID;

  @override
  State<_EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends BaseStatefulState<_EditProfileScreen> {
  final genders = DropDownItems.genders;
  File? _selectedImage;

  final _formKey = GlobalKey<FormBuilderState>();

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialLoad(userID: widget.userID);
    });
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Edit Profile',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getButton();
  }

  @override
  Widget body() {
    final userDetails = context.select((UserViewModel vm) => vm.userDetails);

    return SingleChildScrollView(
      child: Center(
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              if (userDetails != null) ...[
                getProfileImage(imageURL: userDetails.profileImageURL ?? ''),
                SizedBox(height: 60),
                getProfileTextFields(userDetails: userDetails),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _EditProfileScreenState {
  File? get profileImageFile => _selectedImage;

  String? get firstName => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.firstName.name]
      ?.value;

  String? get lastName => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.lastName.name]
      ?.value;

  String? get gender => _formKey
      .currentState
      ?.fields[EditProfileFormFieldsEnum.gender.name]
      ?.value;

  // DateTime get createdDate => userDetails?.createdDate ?? DateTime.now();
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _EditProfileScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onFacePhotoUploadPressed() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> initialLoad({required String userID}) async {
    final userVM = context.read<UserViewModel>();
    await tryLoad(context, () => userVM.getUserDetails(userID: userID));
  }

  Future<void> onSaveButtonPressed() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      String? newProfileImageURL;

      final newImageURL = profileImageFile != null
          ? await tryLoad(
              context,
              () => context.read<FirebaseViewModel>().uploadImage(
                storageRef: StorageRefName.userPhoto,
                images: [profileImageFile ?? File('')],
              ),
            )
          : null;

      newProfileImageURL = newImageURL as String?;

      final result = mounted
          ? await tryLoad(
                  context,
                  () => context.read<UserViewModel>().updateUserDetails(
                    userID: widget.userID,
                    gender: gender ?? '',
                    firstName: firstName ?? '',
                    lastName: lastName ?? '',
                    newProfileImageURL: newProfileImageURL,
                  ),
                ) ??
                false
          : false;

      if (result) {
        unawaited(
          WidgetUtil.showSnackBar(text: 'Profile Updated Successfully'),
        );
        if (mounted) await context.router.maybePop(true);
      } else {
        unawaited(WidgetUtil.showSnackBar(text: 'Failed to update profile'));
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _EditProfileScreenState {
  Widget getProfileImage({required String imageURL}) {
    return Stack(
      children: [
        CustomProfileImage(
          imageFile: _selectedImage,
          imageURL: _selectedImage == null ? imageURL : null,
          imageSize: _Styles.imageSize,
        ),
        Positioned(
          bottom: -2,
          left: 90,
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.lightGreyColor2,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onFacePhotoUploadPressed,
              icon: Icon(
                Icons.camera_alt,
                color: ColorManager.blackColor,
                size: _Styles.cameraIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getProfileTextFields({required UserModel userDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomerNameTextField(
          firstName: userDetails.firstName ?? '',
          lastName: userDetails.lastName ?? '',
        ),
        SizedBox(height: 20),
        getEmailText(email: userDetails.emailAddress ?? ''),
        SizedBox(height: 20),
        getGenderDropdown(gender: userDetails.gender ?? ''),
      ],
    );
  }

  Widget getGenderDropdown({required String gender}) {
    return CustomDropdown(
      formName: EditProfileFormFieldsEnum.gender.name,
      items: genders,
      title: 'Gender',
      fontSize: _Styles.editProfileFormFieldFontSize,
      color: _Styles.editProfileFormFieldColor,
      initialValue: gender,
    );
  }

  Widget getEmailText({required String email}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email Address', style: _Styles.titleTextStyle),
        SizedBox(height: 5),
        Text(email, style: _Styles.valueTextStyle),
      ],
    );
  }

  Widget getCustomerNameTextField({
    required String firstName,
    required String lastName,
  }) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            fontSize: _Styles.editProfileFormFieldFontSize,
            color: _Styles.editProfileFormFieldColor,
            title: 'First Name',
            formName: EditProfileFormFieldsEnum.firstName.name,
            initialValue: firstName,
            validator: FormBuilderValidators.required(),
          ),
        ),
        SizedBox(width: 25),
        Expanded(
          child: CustomTextField(
            fontSize: _Styles.editProfileFormFieldFontSize,
            color: _Styles.editProfileFormFieldColor,
            title: 'Last Name',
            formName: EditProfileFormFieldsEnum.lastName.name,
            initialValue: lastName,
            validator: FormBuilderValidators.required(),
          ),
        ),
      ],
    );
  }

  Widget getButton() {
    return CustomButton(
      text: 'Save',
      textColor: ColorManager.whiteColor,
      onPressed: onSaveButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cameraIconSize = 25.0;
  static const imageSize = 150.0;

  static const editProfileFormFieldFontSize = 16.0;
  static const editProfileFormFieldColor = ColorManager.blackColor;

  static const titleTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.bold,
    color: editProfileFormFieldColor,
  );

  static const valueTextStyle = TextStyle(
    fontSize: editProfileFormFieldFontSize,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
