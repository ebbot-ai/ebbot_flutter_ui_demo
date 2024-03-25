import 'dart:convert';
import 'dart:math';

import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_pages.dart';
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
   await dotenv.load();

   var botId = dotenv.env['BOT_ID'];
   if (botId == null) {
    throw Exception('BOT_ID is not set in .env file');
   }

  runApp(EbbotDemoAppWithPages(botId: botId));
  //runApp(EbbotDemoAppInFullScreen(botId: botId));
}
