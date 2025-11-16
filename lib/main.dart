import 'package:flutter/material.dart';
import 'package:mpma_assignment/app.dart';
import 'package:mpma_assignment/utils/starter_handler.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await init(navigatorKey: navigatorKey);
  await ZegoUIKit().initLog().then((value) async {
    await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
      ZegoUIKitSignalingPlugin(),
    ]);

    runApp(App(navigatorKey: navigatorKey));
  });
}
