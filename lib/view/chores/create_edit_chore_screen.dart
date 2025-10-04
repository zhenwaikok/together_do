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
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/services/chore_services.dart';
import 'package:mpma_assignment/services/space_services.dart';
import 'package:mpma_assignment/services/user_services.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/firebase_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_date_picker.dart';
import 'package:mpma_assignment/widget/custom_dropdown.dart';
import 'package:mpma_assignment/widget/custom_image.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';
import 'package:mpma_assignment/widget/loading_indicator.dart';
import 'package:mpma_assignment/widget/photo_picker.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CreateEditChoreScreen extends StatelessWidget {
  const CreateEditChoreScreen({super.key, required this.isEdit, this.choreID});

  final bool isEdit;
  final String? choreID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        ChoreViewModel(
          choreRepository: ChoreRepository(choreServices: ChoreServices()),
        );
        SpaceViewModel(
          spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
        );
        UserViewModel(
          userRepository: UserRepository(
            sharedPreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
      },
      child: _CreateEditChoreScreen(isEdit: isEdit, choreID: choreID),
    );
  }
}

class _CreateEditChoreScreen extends BaseStatefulPage {
  const _CreateEditChoreScreen({required this.isEdit, this.choreID});
  final bool isEdit;
  final String? choreID;

  @override
  State<_CreateEditChoreScreen> createState() => _CreateEditChoreScreenState();
}

class _CreateEditChoreScreenState
    extends BaseStatefulState<_CreateEditChoreScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<Map<String, String>> availableSpaces = [];
  Map<String, List<Map<String, String>>> spaceMembers = {};
  String? selectedSpaceID;
  bool isCreator = false;
  bool _isLoading = true;
  ChoreModel? choreDetails;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: widget.isEdit ? 'Edit Chore' : 'Create Chore',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget bottomNavigationBar() {
    return isCreator && !_isLoading
        ? getBottomButton(isEdit: widget.isEdit)
        : StylesManager.emptyWidget;
  }

  @override
  Widget body() {
    choreDetails = context.select((ChoreViewModel vm) => vm.choreDetails);

    if (_isLoading || (_isLoading && choreDetails == null)) {
      return LoadingIndicator();
    }

    if (!isCreator && !_isLoading) {
      return Center(
        child: Text(
          'You do not own any space currently. Only space creators can create chores.',
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.center,
        ),
      );
    }

    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isEdit) ...[
              getTitleDescription(),
              SizedBox(height: 20),
            ],
            getTextFields(
              isEdit: widget.isEdit,
              choreDetails: choreDetails ?? ChoreModel(),
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _CreateEditChoreScreenState {
  File? get image => _formKey
      .currentState
      ?.fields[CreateEditChoreFormFieldsEnum.chorePhoto.name]
      ?.value;

  String get title => _formKey
      .currentState
      ?.fields[CreateEditChoreFormFieldsEnum.title.name]
      ?.value;

  String get description => _formKey
      .currentState
      ?.fields[CreateEditChoreFormFieldsEnum.description.name]
      ?.value;

  String get spaceID => _formKey
      .currentState
      ?.fields[CreateEditChoreFormFieldsEnum.space.name]
      ?.value;

  String get assignedUserID => _formKey
      .currentState
      ?.fields[CreateEditChoreFormFieldsEnum.assignedTo.name]
      ?.value;

  DateTime get dueDate => _formKey
      .currentState
      ?.fields[CreateEditChoreFormFieldsEnum.dueDate.name]
      ?.value;
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CreateEditChoreScreenState {
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

  Future<void> fetchData() async {
    if (!widget.isEdit) {
      clearChoreDetails();
    }
    await fetchAvailableSpaces();
    if (widget.isEdit) {
      await fetchChoreDetails();
    }
  }

  void clearChoreDetails() {
    context.read<ChoreViewModel>().clearChoreDetails();
  }

  Future<void> fetchChoreDetails() async {
    _setState(() {
      _isLoading = true;
    });
    await tryCatch(
      context,
      () => context.read<ChoreViewModel>().getChoreDetails(
        choreID: widget.choreID ?? '',
      ),
    );
    final spaceID = mounted
        ? context.read<ChoreViewModel>().choreDetails?.spaceID
        : '';

    _setState(() {
      _isLoading = false;
      onSpaceChanged(spaceID: spaceID ?? '');
    });
  }

  Future<void> fetchAvailableSpaces() async {
    _setState(() {
      _isLoading = true;
    });

    final userID = context.read<UserViewModel>().user?.userID ?? '';
    await tryCatch(
      context,
      () => context.read<SpaceViewModel>().getSpaceByUserID(userID: userID),
    );

    if (mounted) {
      final spaces = context.read<SpaceViewModel>().spaceList;
      _setState(() {
        availableSpaces = spaces
            .where((space) => space.creatorUserID == userID)
            .map((space) {
              return {
                'spaceID': space.id ?? '',
                'creatorUserID': space.creatorUserID ?? '',
                'name': space.name ?? '',
              };
            })
            .toList();

        isCreator = availableSpaces.any(
          (space) => space['creatorUserID'] == userID,
        );
      });

      if (availableSpaces.isNotEmpty) {
        selectedSpaceID = availableSpaces[0]['spaceID'];
      }
      await fetchAvailableMemberDetails(spaces);
    }

    _setState(() {
      _isLoading = false;
    });
  }

  Future<void> fetchAvailableMemberDetails(List<SpaceModel> spaces) async {
    final currentUserID = context.read<UserViewModel>().user?.userID ?? '';
    final Map<String, List<Map<String, String>>> membersBySpace = {};

    for (final space in spaces) {
      final memberIDs = space.memberUserIDs ?? [];

      final memberList = <Map<String, String>>[];
      for (final userID in memberIDs) {
        await tryCatch(
          context,
          () => context.read<UserViewModel>().getUserDetails(
            userID: userID,
            updateSharedPreference: false,
          ),
        );
        final user = mounted ? context.read<UserViewModel>().userDetails : null;

        if (user != null) {
          memberList.add({
            'userID': user.userID ?? '',
            "name": currentUserID == user.userID
                ? '${user.firstName} ${user.lastName} (You)'
                : '${user.firstName} ${user.lastName}',
          });
        }
      }

      membersBySpace[space.id ?? ''] = memberList;
    }

    _setState(() {
      spaceMembers = membersBySpace;
    });
  }

  void onSpaceChanged({required String spaceID}) {
    _setState(() {
      selectedSpaceID = spaceID;
    });
  }

  void onBottomButtonPressed() async {
    final formValid = _formKey.currentState?.saveAndValidate() ?? false;
    final creatorUserID = context.read<UserViewModel>().user?.userID ?? '';

    if (formValid) {
      if (!widget.isEdit) {
        final photoURL = await tryLoad(
          context,
          () => context.read<FirebaseViewModel>().uploadImage(
            storageRef: StorageRefName.chorePhoto,
            images: [image ?? File('')],
          ),
        );

        if (mounted) {
          final result =
              await tryLoad(
                context,
                () => context.read<ChoreViewModel>().addChore(
                  photoURL: photoURL as String,
                  title: title,
                  description: description,
                  dueDate: dueDate,
                  assignedUserID: assignedUserID,
                  spaceID: spaceID,
                  creatorUserID: creatorUserID,
                ),
              ) ??
              false;

          if (result) {
            WidgetUtil.showSnackBar(text: 'Chore created successfully');
            if (mounted) context.router.maybePop();
          }
        }
      } else {
        String newImageURL = '';
        if (image?.path.isNotEmpty ?? false) {
          final imageURL = await tryLoad(
            context,
            () => context.read<FirebaseViewModel>().uploadImage(
              storageRef: StorageRefName.spacePhoto,
              images: [image ?? File('')],
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
          ChoreModel choreModel = ChoreModel(
            id: widget.choreID,
            photoURL: imageURL,
            title: title,
            description: description,
            dueDate: dueDate,
            assignedUserID: assignedUserID,
            spaceID: spaceID,
            creatorUserID: choreDetails?.creatorUserID,
            status: choreDetails?.status,
            createdAt: choreDetails?.createdAt,
            completedAt: choreDetails?.completedAt,
          );

          final result = await tryLoad(
            context,
            () => context.read<ChoreViewModel>().updateChore(
              choreDetails: choreModel,
            ),
          );

          if (result == true) {
            if (mounted) await context.router.maybePop(true);
            WidgetUtil.showSnackBar(text: 'Chore updated successfully');
          }
        }
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CreateEditChoreScreenState {
  Widget getTitleDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create Chore', style: _Styles.titleTextStyle),
        Text(
          'Fill in the details below to create new chore.',
          style: _Styles.descriptionTextStyle,
        ),
      ],
    );
  }

  Widget getTextFields({
    required bool isEdit,
    required ChoreModel choreDetails,
  }) {
    return Column(
      children: [
        getPhotoField(isEdit: isEdit, choreImageURL: choreDetails.photoURL),
        SizedBox(height: 25),
        getChoreTitleField(choreTitle: choreDetails.title),
        SizedBox(height: 25),
        getChoreDescriptionField(choreDescription: choreDetails.description),
        SizedBox(height: 25),
        getAssignToSpaceField(spaceID: choreDetails.spaceID),
        SizedBox(height: 25),
        getAssignToMemberField(assignedToUserID: choreDetails.assignedUserID),
        SizedBox(height: 25),
        getDueDateField(dueDate: choreDetails.dueDate),
      ],
    );
  }

  Widget getPhotoField({String? choreImageURL, required bool isEdit}) {
    return FormBuilderField<File>(
      name: CreateEditChoreFormFieldsEnum.chorePhoto.name,
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

            choreImageURL != null && field.value == null
                ? TouchableOpacity(
                    onPressed: () => onPhotoUploadPressed(field),
                    child: CustomImage(
                      imageURL: choreImageURL,
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

  Widget getChoreTitleField({String? choreTitle}) {
    return CustomTextField(
      title: 'Title',
      fontSize: 17,
      color: ColorManager.blackColor,
      formName: CreateEditChoreFormFieldsEnum.title.name,
      initialValue: choreTitle,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getChoreDescriptionField({String? choreDescription}) {
    return CustomTextField(
      title: 'Description',
      fontSize: 17,
      color: ColorManager.blackColor,
      formName: CreateEditChoreFormFieldsEnum.description.name,
      initialValue: choreDescription,
      validator: FormBuilderValidators.required(),
    );
  }

  Widget getAssignToSpaceField({String? spaceID}) {
    return CustomDropdown(
      formName: CreateEditChoreFormFieldsEnum.space.name,
      unmapItems: availableSpaces.map((space) {
        return DropdownMenuItem<String>(
          value: space['spaceID'],
          child: Text(space['name'] ?? ''),
        );
      }).toList(),
      fontSize: _Styles.fontSize,
      title: 'For Space',
      color: ColorManager.blackColor,
      validator: FormBuilderValidators.required(),
      initialValue:
          spaceID ??
          (availableSpaces.isNotEmpty ? availableSpaces[0]['spaceID'] : null),
      onChanged: (value) {
        onSpaceChanged(spaceID: value ?? '');
      },
    );
  }

  Widget getAssignToMemberField({String? assignedToUserID}) {
    final members = selectedSpaceID != null
        ? (spaceMembers[selectedSpaceID] ?? [])
        : [];

    print('Members: $members');

    return CustomDropdown(
      formName: CreateEditChoreFormFieldsEnum.assignedTo.name,
      unmapItems: members.map((member) {
        return DropdownMenuItem<String>(
          value: member['userID'] ?? '',
          child: Text(member['name'] ?? ''),
        );
      }).toList(),
      fontSize: _Styles.fontSize,
      title: 'Assign To',
      color: ColorManager.blackColor,
      validator: FormBuilderValidators.required(),
      initialValue:
          assignedToUserID ??
          (members.isNotEmpty ? members[0]['userID'] : null),
    );
  }

  Widget getDueDateField({DateTime? dueDate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Due Date', style: _Styles.textFieldTitleTextStyle),
        SizedBox(height: 15),
        CustomDatePickerField(
          formName: CreateEditChoreFormFieldsEnum.dueDate.name,
          suffixIcon: Icon(
            Icons.calendar_today,
            color: ColorManager.greyColor,
            size: _Styles.datePickerIconSize,
          ),
          initialValue: dueDate,
        ),
      ],
    );
  }

  Widget getBottomButton({required bool isEdit}) {
    return CustomButton(
      text: isEdit ? 'Save' : 'Create',
      textColor: ColorManager.whiteColor,
      onPressed: onBottomButtonPressed,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;
  static const datePickerIconSize = 20.0;
  static const imageHeight = 200.0;
  static const fontSize = 16.0;

  static const titleTextStyle = TextStyle(
    fontSize: 17,
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
