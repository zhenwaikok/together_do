import 'dart:io';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/constant/enum/form_type.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/widget/bottom_sheet_action.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';
import 'package:mpma_assignment/widget/text_message_bubble.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';

@RoutePage()
class ChatRoomScreen extends BaseStatefulPage {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends BaseStatefulState<ChatRoomScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final List<XFile> selectedMedia = [];
  final Map<String, Uint8List?> videoThumbnails = {};

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
      actions: [getActions()],
      child: getTopBarReceiverInfo(),
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  Widget bottomNavigationBar() {
    return getBottomMessageInputBar();
  }

  @override
  Widget body() {
    return getMessageList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChatRoomScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void onAddButtonPressed() {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getBottomSheet();
      },
    );
  }

  void onGalleryOptionPressed() async {
    await context.router.maybePop();

    if (selectedMedia.length >= Constant.maxMediaSelectionLimit) {
      WidgetUtil.showSnackBar(
        text:
            'You can select up to ${Constant.maxMediaSelectionLimit} media files only.',
      );
    } else {
      final results = await WidgetUtil.pickMultipleMedias(
        limit: Constant.maxMediaSelectionLimit,
      );

      if (results.isNotEmpty) {
        for (final file in results) {
          final mediaType = WidgetUtil.getMediaType(file.path);
          if (mediaType == MediaType.video) {
            final thumbnail = await generateVideoThumbnail(
              videoFile: File(file.path),
            );
            videoThumbnails[file.path] = thumbnail;
          }
        }

        _setState(() {
          selectedMedia.addAll(results);
        });
      }
    }
  }

  Future<void> onCameraOptionPressed() async {
    await context.router.maybePop();

    if (selectedMedia.length >= Constant.maxMediaSelectionLimit) {
      WidgetUtil.showSnackBar(
        text:
            'You can select up to ${Constant.maxMediaSelectionLimit} media files only.',
      );
    } else {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile != null) {
        _setState(() {
          selectedMedia.addAll([pickedFile]);
        });
      }
    }
  }

  void onDocumentOptionPressed() async {
    await context.router.maybePop();

    if (selectedMedia.length >= Constant.maxMediaSelectionLimit) {
      WidgetUtil.showSnackBar(
        text:
            'You can select up to ${Constant.maxMediaSelectionLimit} media files only.',
      );
    } else {
      final results = await WidgetUtil.pickFiles(
        allowedExtensions: ['pdf', 'docx'],
      );

      if (results.isNotEmpty) {
        _setState(() {
          selectedMedia.addAll(results);
        });
      }
    }
  }

  Future<Uint8List?> generateVideoThumbnail({required File videoFile}) async {
    final thumbnailFile = await WidgetUtil.generateVideoThumbnail(
      videoFile: videoFile,
    );

    return thumbnailFile;
  }

  void onRemoveButtonPressed(int index) {
    _setState(() {
      selectedMedia.removeAt(index);
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChatRoomScreenState {
  Widget getTopBarReceiverInfo() {
    return Row(
      children: [
        getReceiverProfileImage(),
        SizedBox(width: 10),
        getReceiverName(),
      ],
    );
  }

  Widget getReceiverProfileImage() {
    return CustomProfileImage(imageSize: _Styles.profileImageSize);
  }

  Widget getReceiverName() {
    return Text('John Doe', style: _Styles.receiverNameTextStyle);
  }

  Widget getActions() {
    return Padding(
      padding: _Styles.actionPadding,
      child: Row(
        children: [
          getIconButton(icon: Icons.call, onPressed: () {}),
          SizedBox(width: 10),
          getIconButton(icon: Icons.video_chat, onPressed: () {}),
        ],
      ),
    );
  }

  Widget getIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: Container(
        padding: _Styles.actionButtonPadding,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorManager.whiteColor),
      ),
    );
  }

  Widget getMessageList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TextMessageBubble(
          message:
              'asdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdasasdas',
          isMe: false,
          createdTime: DateTime.now(),
        );
      },
    );
  }

  Widget getMediaPreviewSection() {
    return SizedBox(
      height: _Styles.mediaPreviewSectionSize,
      child: ListView.separated(
        padding: _Styles.selectedMediaPadding,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemCount: selectedMedia.length,
        itemBuilder: (context, index) {
          final file = selectedMedia[index];
          final mediaType = WidgetUtil.getMediaType(file.path);

          switch (mediaType) {
            case MediaType.image:
              return getSelectedImage(file: File(file.path), index: index);
            case MediaType.video:
              return getSelectedVideo(
                thumbnail: videoThumbnails[file.path],
                file: File(file.path),
                index: index,
              );
            case MediaType.document:
              return getSelectedDocument(file: File(file.path), index: index);
            default:
              return SizedBox();
          }
        },
      ),
    );
  }

  Widget getSelectedImage({required File file, required int index}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: _Styles.selectedMediaBorderRadius,
              child: Image.file(
                File(file.path),
                width: _Styles.selectedMediaSize,
                height: _Styles.selectedMediaSize,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: -5,
              top: -5,
              child: getRemoveMediaButton(index: index),
            ),
          ],
        ),
        SizedBox(height: 5),
        getMediaFileName(filePath: file.path.split('/').last),
      ],
    );
  }

  Widget getSelectedVideo({
    required Uint8List? thumbnail,
    required File file,
    required int index,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: _Styles.selectedMediaBorderRadius,
              child: Image.memory(
                thumbnail ?? Uint8List(0),
                width: _Styles.selectedMediaSize,
                height: _Styles.selectedMediaSize,
                fit: BoxFit.cover,
              ),
            ),
            Icon(
              Icons.play_circle_fill,
              color: ColorManager.whiteColor,
              size: 24,
            ),
            Positioned(
              right: -5,
              top: -5,
              child: getRemoveMediaButton(index: index),
            ),
          ],
        ),
        SizedBox(height: 5),
        getMediaFileName(filePath: file.path.split('/').last),
      ],
    );
  }

  Widget getSelectedDocument({required File file, required int index}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.lightGreyColor2,
                borderRadius: _Styles.selectedMediaBorderRadius,
              ),
              width: _Styles.selectedMediaSize,
              height: _Styles.selectedMediaSize,
              child: Icon(
                Icons.description,
                size: 40,
                color: ColorManager.blackColor,
              ),
            ),
            Positioned(
              right: -5,
              top: -5,
              child: getRemoveMediaButton(index: index),
            ),
          ],
        ),
        SizedBox(height: 5),
        getMediaFileName(filePath: file.path),
      ],
    );
  }

  Widget getMediaFileName({required String filePath}) {
    return Text(
      filePath.split('/').last,
      maxLines: StylesManager.maxTextLines1,
      style: _Styles.selectedMediaFileTextStyle,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getRemoveMediaButton({required int index}) {
    return TouchableOpacity(
      onPressed: () => onRemoveButtonPressed(index),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: ColorManager.redColor,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close, color: ColorManager.whiteColor, size: 16),
      ),
    );
  }

  Widget getBottomMessageInputBar() {
    return Container(
      padding: _Styles.bottomMessageBarPadding,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedMedia.isNotEmpty) ...[
            getMediaPreviewSection(),
            SizedBox(height: 15),
          ],
          FormBuilder(
            key: formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: getMessageInputField()),
                SizedBox(width: 10),
                getMessageButton(
                  icon: Icons.add,
                  buttonColor: ColorManager.blackColor,
                  onPressed: onAddButtonPressed,
                ),
                SizedBox(width: 10),
                getMessageButton(
                  icon: Icons.send,
                  buttonColor: ColorManager.primary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getMessageInputField() {
    return CustomTextField(
      needTitle: false,
      formName: ChatFormFieldsEnum.message.name,
      hintText: 'Type a message...',
    );
  }

  Widget getMessageButton({
    required IconData icon,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: CircleAvatar(
        backgroundColor: ColorManager.lightGreyColor3,
        child: Icon(icon, color: buttonColor),
      ),
    );
  }

  Widget getBottomSheet() {
    return Padding(
      padding: StylesManager.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.camera_alt,
            color: ColorManager.blackColor,
            text: 'Camera',
            onTap: onCameraOptionPressed,
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.image,
            color: ColorManager.blackColor,
            text: 'Select from Gallery',
            onTap: onGalleryOptionPressed,
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.description,
            color: ColorManager.blackColor,
            text: 'Document',
            onTap: onDocumentOptionPressed,
          ),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  static const profileImageSize = 30.0;
  static const selectedMediaSize = 70.0;
  static const mediaPreviewSectionSize = 100.0;

  static const BorderRadius selectedMediaBorderRadius = BorderRadius.all(
    Radius.circular(8.0),
  );

  static const EdgeInsets actionPadding = EdgeInsets.only(right: 15.0);
  static const EdgeInsets actionButtonPadding = EdgeInsets.all(8.0);
  static const EdgeInsets bottomMessageBarPadding = EdgeInsets.all(20.0);
  static const EdgeInsets selectedMediaPadding = EdgeInsets.symmetric(
    vertical: 5,
    horizontal: 5,
  );

  static const receiverNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorManager.blackColor,
  );

  static const selectedMediaFileTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
