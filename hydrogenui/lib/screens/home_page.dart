import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydrogenui/widgets/custom_card.dart';
import 'package:hydrogenui/widgets/terminal_input.dart';

class ClockController extends GetxController {
  var time = ''.obs;
  Timer? _timer;

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

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class MyHomePage extends StatelessWidget {
  final ClockController controller = Get.put(ClockController());

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(child: Text('PANEL SYSTEM', style: TextStyle(),)),
                      Expanded(
                        child: Card(
                          child: Center(
                            child: Obx(
                              () => Text(
                                controller.time.value,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    height: Get.height,
                    padding: const EdgeInsets.all(8),
                    child: TerminalInput(),
                  ),
                ),
                Expanded(child: Placeholder()),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                SizedBox(
                  width: Get.width / 2,
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
                // const SizedBox(width: 8),
                SizedBox(width: Get.width / 2, child: Placeholder()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
