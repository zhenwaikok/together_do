import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/widget/chat_card_wrapper.dart';
import 'package:video_player/video_player.dart';

class VideoMessageBubble extends StatefulWidget {
  const VideoMessageBubble({
    super.key,
    required this.videoURL,
    required this.isMe,
    required this.createdTime,
  });

  final String videoURL;
  final bool isMe;
  final DateTime createdTime;

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(videoURL: widget.videoURL);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChatCardWrapper(
      createdTime: widget.createdTime,
      isMe: widget.isMe,
      child: getVideoPlayer(),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _VideoMessageBubbleState {
  void initializeVideoPlayer({required String videoURL}) {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoURL),
    );
    videoPlayerController.initialize().then((_) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
      );
      _setState(() {});
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _VideoMessageBubbleState {
  Widget getVideoPlayer() {
    return videoPlayerController.value.isInitialized
        ? Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.black),
            clipBehavior: Clip.hardEdge,
            child: Chewie(controller: chewieController),
          )
        : Center(child: CircularProgressIndicator(color: ColorManager.primary));
  }
}
