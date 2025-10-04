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
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/services/space_services.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/firebase_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_image.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';
import 'package:mpma_assignment/widget/photo_picker.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CreateEditSpaceScreen extends StatelessWidget {
  const CreateEditSpaceScreen({super.key, required this.isEdit, this.spaceID});

  final bool isEdit;
  final String? spaceID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpaceViewModel(
        spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
      ),
      child: _CreateEditSpaceScreen(isEdit: isEdit, spaceID: spaceID),
    );
  }
}

class _CreateEditSpaceScreen extends BaseStatefulPage {
  const _CreateEditSpaceScreen({required this.isEdit, this.spaceID});

  final bool isEdit;
  final String? spaceID;

  @override
  State<_CreateEditSpaceScreen> createState() => _CreateEditSpaceScreenState();
}

class _CreateEditSpaceScreenState
    extends BaseStatefulState<_CreateEditSpaceScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.isEdit ? 'Edit Space' : 'Create Space',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return getBottomButton(isEdit: widget.isEdit);
  }

  @override
  Widget body() {
    final spaceDetails = context.select((SpaceViewModel vm) => vm.spaceDetails);

    if (widget.isEdit && spaceDetails == null) {
      return StylesManager.emptyWidget;
    }

    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            if (!widget.isEdit) ...[
              getTitleDescription(),
              SizedBox(height: 20),
            ],
            getTextFields(isEdit: widget.isEdit, spaceDetails: spaceDetails),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helper ----------------------------
extension _Helper on _CreateEditSpaceScreenState {
  String get spaceName =>
      _formKey
          .currentState
          ?.fields[CreateEditSpaceFormFieldsEnum.name.name]
          ?.value ??
      '';

  String get spaceDescription =>
      _formKey
          .currentState
          ?.fields[CreateEditSpaceFormFieldsEnum.description.name]
          ?.value ??
      '';

  File get spacePhoto =>
      _formKey
          .currentState
          ?.fields[CreateEditSpaceFormFieldsEnum.spacePhoto.name]
          ?.value ??
      File('');
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CreateEditSpaceScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> onPhotoUploadPressed(FormFieldState<File> field) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      field.didChange(image);
    }
  }

  void onCreateSpacePressed() async {
    final creatorUserID = context.read<UserViewModel>().user?.userID ?? '';

    final formValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (formValid) {
      if (!widget.isEdit) {
        final imageURL = await tryLoad(
          context,
          () => context.read<FirebaseViewModel>().uploadImage(
            storageRef: StorageRefName.spacePhoto,
            images: [spacePhoto],
          ),
        );

        if (mounted) {
          final result = await tryLoad(
            context,
            () => context.read<SpaceViewModel>().addSpace(
              spaceName: spaceName,
              description: spaceDescription,
              imageURL: imageURL as String,
              creatorUserID: creatorUserID,
            ),
          );

          if (result == true) {
            if (mounted) await context.router.maybePop(true);
            WidgetUtil.showSnackBar(text: 'Space created successfully');
          }
        }
      } else {
        String newImageURL = '';
        if (spacePhoto.path.isNotEmpty) {
          final imageURL = await tryLoad(
            context,
            () => context.read<FirebaseViewModel>().uploadImage(
              storageRef: StorageRefName.spacePhoto,
              images: [spacePhoto],
            ),
          );

          newImageURL = imageURL as String;
        }

        final imageURL = newImageURL.isNotEmpty
            ? newImageURL
            : mounted
            ? context.read<SpaceViewModel>().spaceDetails?.imageURL ?? ''
            : '';

        if (mounted) {
          final result = await tryLoad(
            context,
            () => context.read<SpaceViewModel>().updateSpace(
              spaceID: widget.spaceID ?? '',
              spaceName: spaceName,
              description: spaceDescription,
              imageURL: imageURL,
            ),
          );

          if (result == true) {
            if (mounted) await context.router.maybePop(true);
            WidgetUtil.showSnackBar(text: 'Space updated successfully');
          }
        }
      }
    }
  }

  Future<void> initialLoad() async {
    if (widget.isEdit) {
      await tryLoad(
        context,
        () => context.read<SpaceViewModel>().getSpaceDetails(
          spaceID: widget.spaceID ?? '',
        ),
      );
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CreateEditSpaceScreenState {
  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create Space', style: _Styles.titleTextStyle),
        Text(
          'Fill in the details below to create new space for managing chores.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getTextFields({required bool isEdit, SpaceModel? spaceDetails}) {
    return Column(
      children: [
        getPhotoField(isEdit: isEdit, spaceImageURL: spaceDetails?.imageURL),
        SizedBox(height: 25),
        getSpaceNameField(spaceName: spaceDetails?.name),
        SizedBox(height: 25),
        getSpaceDescriptionField(spaceDescription: spaceDetails?.description),
      ],
    );
  }

  Widget getPhotoField({String? spaceImageURL, required bool isEdit}) {
    return FormBuilderField<File>(
      name: CreateEditSpaceFormFieldsEnum.spacePhoto.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null && !isEdit) return '  This field cannot be empty.';
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Photo', style: _Styles.textFieldTitleTextStyle),
            if (isEdit) ...[
              Text('**Tap photo to change', style: _Styles.noteTextStyle),
            ],
            SizedBox(height: 10),

            spaceImageURL != null && field.value == null
                ? TouchableOpacity(
                    onPressed: () => onPhotoUploadPressed(field),
                    child: CustomImage(
                      imageURL: spaceImageURL,
                      imageWidth: double.infinity,
                      imageSize: _Styles.imageHeight,
                    ),
                  )
                : PhotoPicker(
                    borderRadius: _Styles.borderRadius,
                    onTap: () {
                      onPhotoUploadPressed(field);
                    },
                    selectedImage: field.value ?? File(''),
                  ),
            if (field.hasError)
              Padding(
                padding: _Styles.errorTextPadding,
                child: Text(
                  field.errorText ?? '',
                  style: _Styles.errorTextStyle,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget getSpaceNameField({String? spaceName}) {
    return CustomTextField(
      title: 'Space Name',
      fontSize: 17,
      color: ColorManager.blackColor,
      formName: CreateEditSpaceFormFieldsEnum.name.name,
      initialValue: spaceName,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getSpaceDescriptionField({String? spaceDescription}) {
    return CustomTextField(
      title: 'Description',
      fontSize: 17,
      color: ColorManager.blackColor,
      formName: CreateEditSpaceFormFieldsEnum.description.name,
      initialValue: spaceDescription,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getBottomButton({required bool isEdit}) {
    return CustomButton(
      text: isEdit ? 'Save' : 'Create',
      textColor: ColorManager.whiteColor,
      onPressed: onCreateSpacePressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;

  static const imageHeight = 200.0;

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const textFieldTitleTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const noteTextStyle = TextStyle(
    fontSize: 15,
    color: ColorManager.greyColor,
  );

  static const errorTextStyle = TextStyle(fontSize: 12, color: Colors.red);

  static const errorTextPadding = EdgeInsets.only(top: 5);
}
