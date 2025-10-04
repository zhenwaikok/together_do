import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/utils/extensions/string_extension.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/widget/custom_bar.dart';
import 'package:mpma_assignment/widget/custom_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChoreCard extends StatelessWidget {
  const ChoreCard({
    super.key,
    required this.chore,
    this.choreAssignedNames,
    this.isLoading = false,
    this.needAssignedNames = true,
    this.needRightPadding = false,
  });

  final ChoreModel chore;
  final Map<String, String>? choreAssignedNames;
  final bool isLoading;
  final bool needAssignedNames;
  final bool needRightPadding;

  @override
  Widget build(BuildContext context) {
    return getChoreCard(
      chore: chore,
      choreAssignedNames: choreAssignedNames ?? {},
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on ChoreCard {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ChoreCard {
  Widget getChoreCard({
    required ChoreModel chore,
    required Map<String, String> choreAssignedNames,
  }) {
    return Padding(
      padding: needRightPadding
          ? _Styles.choreCardPadding
          : StylesManager.zeroPadding,
      child: CustomCard(
        padding: _Styles.cardPadding,
        needBorder: true,
        needBoxShadow: false,
        backgroundColor: ColorManager.whiteColor,
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              getChoreNameAndStatus(
                choreName: chore.title ?? '',
                status: chore.status ?? '',
              ),
              SizedBox(height: 10),
              getDueAndAssigned(
                dueDate: chore.dueDate ?? DateTime.now(),
                choreID: chore.id ?? '',
                choreAssignedNames: choreAssignedNames,
                createdAt: chore.createdAt ?? DateTime.now(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getChoreNameAndStatus({
    required String choreName,
    required String status,
  }) {
    final backgroundColor = WidgetUtil.getChoreStatusColor(status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            choreName,
            style: _Styles.choreNameTextStyle,
            maxLines: StylesManager.maxTextLines1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 20),
        CustomBar(
          backgroundColor: backgroundColor,
          child: Text(status, style: _Styles.whiteTextStyle),
        ),
      ],
    );
  }

  Widget getDueAndAssigned({
    required DateTime dueDate,
    required String choreID,
    required Map<String, String> choreAssignedNames,
    required DateTime createdAt,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getChoreText(
          icon: Icons.calendar_today,
          text:
              'Due: ${StringExtension.dateToDayFormatter(dueDate)}, ${StringExtension.dateFormatter(dueDate)}',
        ),
        SizedBox(height: 10),
        if (needAssignedNames) ...[
          getChoreText(
            icon: Icons.person,
            text: 'Assigned to: ${choreAssignedNames[choreID]}',
          ),
          SizedBox(height: 10),
        ],
        getChoreText(
          icon: Icons.access_time,
          text: 'Created ${StringExtension.differenceBetweenDate(createdAt)}',
        ),
      ],
    );
  }

  Widget getChoreText({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: _Styles.iconSize, color: ColorManager.greyColor),
        SizedBox(width: 5),
        Text(
          text,
          style: _Styles.smallGreyTextStyle,
          maxLines: StylesManager.maxTextLines1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 15.0;

  static const cardPadding = EdgeInsets.all(10);
  static const choreCardPadding = EdgeInsets.only(right: 10);

  static const whiteTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );

  static const smallGreyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const choreNameTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
