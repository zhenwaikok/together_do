import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/firebase_options.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> init({required GlobalKey<NavigatorState> navigatorKey}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermission();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHandler().initialize();

  final user = SharedPreferenceHandler().getUser();

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  await ZegoUIKitPrebuiltCallInvitationService().init(
    appID: int.parse(EnvValues.zegoAppID),
    appSign: EnvValues.appSign,
    userID: user?.userID ?? '',
    userName: '${user?.firstName} ${user?.lastName}',
    plugins: [ZegoUIKitSignalingPlugin()],
    invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(),
  );
}

Future<void> requestPermission() async {
  await [
    Permission.camera,
    Permission.microphone,
    Permission.notification,
  ].request();
}
