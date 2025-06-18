// ignore: unused_import, depend_on_referenced_packages
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_behaviour.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_callback.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_chat.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_configuration.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_log_configuration.dart';
import 'package:ebbot_flutter_ui/v1/configuration/ebbot_user_configuration.dart';
import 'package:ebbot_flutter_ui/v1/controller/ebbot_api_controller.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:ebbot_flutter_ui_demo/example/ebbot_demo_app_with_popup.dart';
import 'package:flutter/material.dart';
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

Future<void> onSessionData(String chatId) async {
  print("CALLBACK: onSessionData, chatId: $chatId");
}

var apiController = EbbotApiController();

Environment getEnvironmentFromString(String environmentString) {
  switch (environmentString.toLowerCase()) {
    case 'ovheuproduction':
      return Environment.ovhEUProduction;
    case 'googleeuproduction':
      return Environment.googleEUProduction;
    case 'googlecanadaproduction':
      return Environment.googleCanadaProduction;
    case 'staging':
      return Environment.staging;
    default:
      throw Exception(
          'Unknown environment: $environmentString. Available environments: ovhEUProduction, googleEUProduction, googleCanadaProduction, release, staging');
  }
}

Future main() async {
  await dotenv.load();

  var botId = dotenv.env['BOT_ID'];
  if (botId == null) {
    throw Exception('BOT_ID is not set in .env file');
  }

  var environmentString = dotenv.env['ENVIRONMENT'] ?? 'ovhEUProduction';
  var environment = getEnvironmentFromString(environmentString);

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
      .onSessionData(onSessionData)
      .build();

  var ebbotBehaviourInput = EbbotBehaviourInputBuilder()
      .enterPressed(EbbotBehaviourInputEnterPressed.sendMessage)
      .build();
  var behaviour = EbbotBehaviourBuilder().input(ebbotBehaviourInput).build();

  var logConfiguration = EbbotLogConfigurationBuilder()
      .logLevel(EbbotLogLevel.debug)
      .enabled(true)
      .build();

  final ratingSelected = Image.asset("assets/sunglasses.png");
  final rating =
      Opacity(opacity: 0.5, child: Image.asset("assets/sunglasses.png"));

  var chat =
      EbbotChatBuilder().rating(rating).ratingSelected(ratingSelected).build();

  //var someChatId =
  ""; // Provide your chatId here, it can be obtained from the onSessionData callback
  //var session = EbbotSessionBuilder().chatId(someChatId).build();

  var configuration = EbbotConfigurationBuilder()
      .apiController(apiController)
      .environment(environment)
      .userConfiguration(userConfiguration)
      .behaviour(behaviour)
      .callback(callback)
      .logConfiguration(logConfiguration)
      .chat(chat)
      //.session(session)
      .build();

  //runApp(EbbotDemoAppWithPages(botId: botId, configuration: configuration));
  runApp(EbbotDemoAppInFullScreen(botId: botId, configuration: configuration));
  //runApp(EbbotDemoAppToggleShow(botId: botId, configuration: configuration));
}
