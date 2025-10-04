import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/firebase_options.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHandler().initialize();
}
