// ignore: unused_import, depend_on_referenced_packages
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_configuration.dart';
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_pages.dart';
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();

  var botId = dotenv.env['BOT_ID'];
  if (botId == null) {
    throw Exception('BOT_ID is not set in .env file');
  }

  var userAttributes = {
    'name': 'John Doe',
    'email': 'john@doe.com',
    'age': 30,
    'height': 180.0,
    'isPremium': true,
    'lastLogin': DateTime.now().millisecondsSinceEpoch
  };

  var configuration = EbbotConfigurationBuilder()
      .environment(Environment.ovhEUProduction)
      .userAttributes(userAttributes)
      .theme(const ForestChatTheme())
      .build();

  runApp(EbbotDemoAppWithPages(botId: botId, configuration: configuration));
  //runApp(EbbotDemoAppInFullScreen(botId: botId, configuration: configuration));
}

class ForestChatTheme extends DefaultChatTheme {
  const ForestChatTheme(
      {super.primaryColor = const Color(0xFF00A372),
      super.userAvatarImageBackgroundColor = const Color(0xFF00A372),
      super.userAvatarNameColors = const [Color(0xFF00A372)],
      super.typingIndicatorTheme = const TypingIndicatorTheme(
        animatedCirclesColor: neutral1,
        animatedCircleSize: 5.0,
        bubbleBorder: BorderRadius.all(Radius.circular(27.0)),
        bubbleColor: neutral7,
        countAvatarColor: Color(0xFF00A372),
        countTextColor: Color(0xFF00A372),
        multipleUserTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: neutral2,
        ),
      )});
}
