import 'package:ebbot_flutter_ui/v1/configuration/ebbot_configuration.dart';
import 'package:ebbot_flutter_ui/v1/ebbot_flutter_ui.dart';
import 'package:flutter/material.dart';

class EbbotDemoAppToggleShow extends StatelessWidget {
  final String botId;
  final EbbotConfiguration configuration;
  const EbbotDemoAppToggleShow(
      {super.key, required this.botId, required this.configuration});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Toggling chat widget')),
        body: EbbotDemoAppToggleShowHome(
            botId: botId, configuration: configuration),
      ),
    );
  }
}

class EbbotDemoAppToggleShowHome extends StatefulWidget {
  final String botId;
  final EbbotConfiguration configuration;
  const EbbotDemoAppToggleShowHome(
      {super.key, required this.botId, required this.configuration});

  @override
  EbbotDemoAppToggleShowHomeState createState() =>
      EbbotDemoAppToggleShowHomeState();
}

class EbbotDemoAppToggleShowHomeState
    extends State<EbbotDemoAppToggleShowHome> {
  bool showWidget = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showWidget)
          Flexible(
            child: EbbotFlutterUi(
              key: const PageStorageKey('ToggleShowWidget'),
              botId: widget.botId,
              configuration: widget.configuration,
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showWidget = !showWidget; // Toggle widget visibility
            });
          },
          child: Text(showWidget ? 'Remove Widget' : 'Re-add Widget'),
        ),
      ],
    );
  }
}
