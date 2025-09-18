import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydrogenui/widgets/custom_card.dart';
import 'package:hydrogenui/widgets/terminal_input.dart';
import 'dart:io';

class ClockController extends GetxController {
  var time = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _update();
  }

  void _update() {
    final now = DateTime.now();
    time.value =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    Future.delayed(const Duration(seconds: 1), _update);
  }
}

class MyHomePage extends StatelessWidget {
  final ClockController controller = Get.put(ClockController());

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        // Colonna principale
        child: Column(
          children: [
            Expanded(
              flex: 3,
              // Riga Principale
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    // Colonna Panel System
                    child: Column(
                      children: [
                        Text(
                          'PANEL SYSTEM',
                          style: TextStyle(wordSpacing: 270),
                        ),
                        _CustomDivider(context),
                        Expanded(
                          child: Card(
                            child: Center(
                              child: Obx(
                                () => Text(
                                  controller.time.value,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: CustomCard(title: "Network Monitor")),
                        Expanded(child: CustomCard(title: "File Explorer")),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    // Colonna del Terminal
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TERMINAL MAIN',
                                style: TextStyle(wordSpacing: 320),
                              ),
                              _TerminalChoice(platform: _PlatformCheck()),
                              // Widget per selezionare il terminale da usare
                            ],
                          ),
                        ),
                        _CustomDivider(context),
                        const SizedBox(height: 2),
                        Expanded(child: TerminalInput()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // Colonna del Network
                    child: Column(
                      children: [
                        Text(
                          'PANEL NETWORK',
                          style: TextStyle(wordSpacing: 270),
                        ),
                        _CustomDivider(context),
                        Expanded(child: CustomCard(title: "Network Stats")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              // Riga Secondaria
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      // Gestore delle Cartelle
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Icon(Icons.folder);
                        },
                      ),
                    ),
                  ),
                  // const SizedBox(width: 8),
                  Expanded(child: SizedBox(child: Placeholder())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _PlatformCheck() {
  if (Platform.isWindows) {
    return 0;
  } else if (Platform.isLinux) {
    return 1;
  } else if (Platform.isMacOS) {
    return 2;
  } else if (Platform.isAndroid) {
    return 3;
  } else if (Platform.isIOS) {
    return 4;
  } else {
    // print("Sistema operativo sconosciuto: ${Platform.operatingSystem}");
    return -1;
  }
}

class _TerminalController extends GetxController {
  var selectedTerminal = ''.obs; // valore selezionato
}

class _TerminalChoice extends StatelessWidget {
  final int platform;
  final _TerminalController controller = Get.put(_TerminalController());

  final List<DropdownMenuItem<String>> allTerminal = [
    DropdownMenuItem(value: 'cmd', child: Text('CMD')), // Solo Windows
    DropdownMenuItem(
      value: 'powershell',
      child: Text('PowerShell'),
    ), // Solo Windows
    DropdownMenuItem(value: 'zsh', child: Text('Zsh')), // Solo macOS
    DropdownMenuItem(value: 'bash', child: Text('Bash')), // Linux, macOS
    DropdownMenuItem(value: 'sh', child: Text('Sh')), // Linux
  ];

  List<DropdownMenuItem<String>> get items {
    switch (platform) {
      case 0:
        return allTerminal.sublist(0, 2); // Windows
      case 1:
        return allTerminal.sublist(3, 5); // Linux
      case 2:
        return allTerminal.sublist(2, 4); // macOS
      default:
        return [];
    }
  }

  _TerminalChoice({required this.platform});

  @override
  Widget build(BuildContext context) {
    // Imposta un valore iniziale se non c'è
    if (controller.selectedTerminal.value == '' && items.isNotEmpty) {
      controller.selectedTerminal.value = items.first.value!;
    }

    return Obx(
      () => SizedBox(
        height: 20,
        child: DropdownButton<String>(
          underline: SizedBox.shrink(),
          style: TextStyle(fontSize: 15),
          value: controller.selectedTerminal.value,
          items: items,
          onChanged: (value) {
            if (value != null) controller.selectedTerminal.value = value;
          },
        ),
      ),
    );
  }
}

Widget _CustomDivider(context) {
  return Divider(
    indent: 10,
    endIndent: 10,
    color: Theme.of(context).colorScheme.primary,
    thickness: 2,
  );
}
