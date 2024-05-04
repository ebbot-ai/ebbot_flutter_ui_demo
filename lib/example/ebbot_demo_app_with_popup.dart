import 'package:ebbot_flutter_ui/v1/configuration/ebbot_configuration.dart';
import 'package:ebbot_flutter_ui/v1/ebbot_flutter_ui.dart';
import 'package:flutter/material.dart';

class EbbotDemoAppInFullScreen extends StatelessWidget {
  final String botId;
  final EbbotConfiguration configuration;
  const EbbotDemoAppInFullScreen(
      {super.key, required this.botId, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ebbot Fullscreen Chat Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: EbbotDemoAppInFullScreenHome(
          botId: botId, configuration: configuration),
    );
  }
}

class EbbotDemoAppInFullScreenHome extends StatelessWidget {
  final String botId;
  final EbbotConfiguration configuration;
  const EbbotDemoAppInFullScreenHome(
      {super.key, required this.botId, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat demo'),
      ),
      body: Center(
        child: OpenDialogButton(botId: botId, configuration: configuration),
      ),
    );
  }
}

class OpenDialogButton extends StatelessWidget {
  final String botId;
  final EbbotConfiguration configuration;
  const OpenDialogButton(
      {super.key, required this.botId, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EbbotUiWidgetFullscreen(
                botId: botId, configuration: configuration);
          },
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          barrierLabel: 'Close',
        );
      },
      child: const Text('Open chat in fullscreen'),
    );
  }
}

class EbbotUiWidgetFullscreen extends StatelessWidget {
  final String botId;
  final EbbotConfiguration configuration;
  final double widthRatio = 0.9;
  final double heightRatio = 0.9;

  const EbbotUiWidgetFullscreen(
      {super.key, required this.botId, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        // Apply clip to ensure rounded corners for content
        borderRadius: BorderRadius.circular(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              widthRatio, // 80% of screen width
          height: MediaQuery.of(context).size.height *
              heightRatio, // 80% of screen height
          child: Column(
            children: [
              // Dismiss button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              // Content
              Expanded(
                child: EbbotFlutterUi(
                  key: const PageStorageKey('ChatPage'),
                  botId: botId,
                  configuration: configuration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
