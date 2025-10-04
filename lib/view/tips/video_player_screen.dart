import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key, required this.videoId});

  final String videoId;

  @override
  Widget build(BuildContext context) {
    return _VideoPlayerScreen(videoId: videoId);
  }
}

class _VideoPlayerScreen extends BaseStatefulPage {
  const _VideoPlayerScreen({required this.videoId});

  final String videoId;

  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends BaseStatefulState<_VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    setUpController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? appbar() {
    final orientarion = MediaQuery.of(context).orientation;
    if (orientarion == Orientation.landscape) {
      return null;
    }

    return CustomAppBar(
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: ColorManager.whiteColor,
        progressColors: ProgressBarColors(
          playedColor: ColorManager.whiteColor,
          handleColor: ColorManager.whiteColor,
        ),
      ),
      builder: (context, player) {
        return Center(child: player);
      },
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _VideoPlayerScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  void setUpController() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(mute: false, autoPlay: true),
    );
  }
}
