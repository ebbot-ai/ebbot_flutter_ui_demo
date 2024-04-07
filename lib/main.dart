import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_configuration.dart';
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();

  var botId = dotenv.env['BOT_ID'];
  if (botId == null) {
    throw Exception('BOT_ID is not set in .env file');
  }

  var configuration = EbbotConfigurationBuilder()
      .environment(Environment.ovhEUProduction)
      .build();

  runApp(EbbotDemoAppWithPages(botId: botId, configuration: configuration));
  //runApp(EbbotDemoAppInFullScreen(botId: botId, configuration: configuration));
}
