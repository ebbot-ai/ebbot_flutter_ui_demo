// ignore: unused_import, depend_on_referenced_packages
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_behaviour.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_callback.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_configuration.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_log_configuration.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_user_configuration.dart';
import 'package:ebbot_flutter_ui/v1/controller/ebbot_api_controller.dart';
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_pages.dart';
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> onLoadError(EbbotLoadError error) async {
  print("CALLBACK: onLoadError: $error");
}

bool hasAlreadyRestarted = false;

Future<void> onLoad() async {
  print("CALLBACK: onLoad");
}

Future<void> onRestartConversation() async {
  print("CALLBACK: onRestartConversation");
}

Future<void> onEndConversation() async {
  print("CALLBACK: onEndConversation");
}

Future<void> onMessage(String message) async {
  print("CALLBACK: onMessage: $message");
}

Future<void> onBotMessage(String message) async {
  print("CALLBACK: onBotMessage: $message");
}

Future<void> onUserMessage(String message) async {
  print("CALLBACK: onUserMessage: $message");
}

Future<void> onStartConversation(String message) async {
  print("CALLBACK: onStartConversation");
}

var apiController = EbbotApiController();

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

  var userConfiguration =
      EbbotUserConfigurationBuilder().userAttributes(userAttributes).build();

  var callback = EbbotCallbackBuilder()
      .onLoadError(onLoadError)
      .onLoad(onLoad)
      .onRestartConversation(onRestartConversation)
      .onEndConversation(onEndConversation)
      .onMessage(onMessage)
      .onBotMessage(onBotMessage)
      .onUserMessage(onUserMessage)
      .onStartConversation(onStartConversation)
      .build();

  var ebbotBehaviourInput = EbbotBehaviourInputBuilder()
      .enterPressed(EbbotBehaviourInputEnterPressed.sendMessage)
      .build();
  var behaviour = EbbotBehaviourBuilder().input(ebbotBehaviourInput).build();

  var logConfiguration = EbbotLogConfigurationBuilder().logLevel(EbbotLogLevel.info).enabled(true).build();

  var configuration = EbbotConfigurationBuilder()
      .apiController(apiController)
      .environment(Environment.ovhEUProduction)
      .userConfiguration(userConfiguration)
      .behaviour(behaviour)
      .theme(const ForestChatTheme())
      .callback(callback)
      .logConfiguration(logConfiguration)
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
