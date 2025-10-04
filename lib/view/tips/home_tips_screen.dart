import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/youtube_response_model/youtube_response_model.dart';
import 'package:mpma_assignment/repository/home_tips_repository.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/services/home_tips_services.dart';
import 'package:mpma_assignment/utils/extensions/string_extension.dart';
import 'package:mpma_assignment/viewmodel/home_tips_view_model.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_image.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeTipsScreen extends StatelessWidget {
  const HomeTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeTipsViewModel(
        homeTipsRepository: HomeTipsRepository(
          homeTipsServices: HomeTipsServices(),
        ),
      ),
      child: _HomeTipsScreen(),
    );
  }
}

class _HomeTipsScreen extends BaseStatefulPage {
  @override
  State<_HomeTipsScreen> createState() => _HomeTipsScreenState();
}

class _HomeTipsScreenState extends BaseStatefulState<_HomeTipsScreen> {
  bool _isLoading = true;

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
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'Home Tips', isBackButtonVisible: false);
  }

  @override
  Widget body() {
    final youtubeResponse = context.select(
      (HomeTipsViewModel vm) => vm.youtubeResponse,
    );

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        ...getTipsList(
          youtubeResponse: youtubeResponse ?? YoutubeResponseModel(),
          isLoading: _isLoading,
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _HomeTipsScreenState {
  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });
    await tryCatch(
      context,
      () => context.read<HomeTipsViewModel>().fetchAllHomeTipsVideos(),
    );
    _setState(() {
      _isLoading = false;
    });
  }

  void onTipCardPressed(String videoId) {
    context.router.push(VideoPlayerRoute(videoId: videoId));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _HomeTipsScreenState {
  List<Widget> getTipsList({
    required YoutubeResponseModel youtubeResponse,
    required bool isLoading,
  }) {
    final tipsList = youtubeResponse.items ?? [];

    final loadingList = List.generate(
      5,
      (index) => YoutubeItem(snippet: YoutubeSnippet(title: 'Loading...')),
    );

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final tips = isLoading ? loadingList[index] : tipsList[index];

          return Column(
            children: [
              Padding(
                padding: _Styles.tipsContentPadding,
                child: Skeletonizer(
                  enabled: isLoading,
                  child: getTipsContent(
                    imageURL: tips.snippet?.thumbnails?.medium?.url ?? '',
                    title: tips.snippet?.title ?? '',
                    postedDate: tips.snippet?.publishedAt ?? DateTime.now(),
                    videoId: tips.id?.videoId ?? '',
                  ),
                ),
              ),
              Divider(color: ColorManager.lightGreyColor),
            ],
          );
        }, childCount: isLoading ? loadingList.length : tipsList.length),
      ),
    ];
  }

  Widget getTipsContent({
    required String imageURL,
    required String title,
    required DateTime postedDate,
    required String videoId,
  }) {
    return TouchableOpacity(
      onPressed: () => onTipCardPressed(videoId),
      child: Row(
        children: [
          getTipsThumbnail(imageURL: imageURL),
          SizedBox(width: 20),
          Expanded(
            child: getTipsDetails(title: title, postedDate: postedDate),
          ),
        ],
      ),
    );
  }

  Widget getTipsThumbnail({required String imageURL}) {
    return CustomImage(
      imageSize: MediaQuery.of(context).size.width * 0.3,
      borderRadius: _Styles.borderRadius,
      imageURL: imageURL,
    );
  }

  Widget getTipsDetails({required String title, required DateTime postedDate}) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringExtension.decodeHtmlString(htmlString: title),
            style: _Styles.tipsTitleTextStyle,
            textAlign: TextAlign.justify,
            maxLines: StylesManager.maxTextLines3,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.history,
                size: _Styles.iconSize,
                color: ColorManager.primary,
              ),
              SizedBox(width: 5),
              Text(
                'Posted ${StringExtension.differenceBetweenDate(postedDate)}',
                style: _Styles.tipsPostedTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 15.0;
  static const iconSize = 15.0;

  static const tipsContentPadding = EdgeInsets.symmetric(vertical: 15);

  static const tipsTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const tipsPostedTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );
}
