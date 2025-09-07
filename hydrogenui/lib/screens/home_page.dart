import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydrogenui/widgets/custom_card.dart';
import 'package:hydrogenui/widgets/terminal_input.dart';

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
                        Expanded(
                          child: Text(
                            'PANEL SYSTEM',
                            style: TextStyle(wordSpacing: 320),
                          ),
                        ),
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

                              // Widget per selezionare il terminale da usare
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Expanded(child: TerminalInput()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // Colonna del Network
                    child: Column(children: []),
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
