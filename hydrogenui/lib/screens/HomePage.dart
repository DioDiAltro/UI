import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydrogenui/widgets/TerminalInput.dart';

class ClockController extends GetxController {
  var time = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _update();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _update());
  }

  void _update() {
    final now = DateTime.now();
    time.value =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'EDexUI',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
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
                    Expanded(
                      child: Card(
                        child: Center(child: Text("Network Monitor")),
                      ),
                    ),
                    Expanded(
                      child: Card(child: Center(child: Text("File Explorer"))),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: Get.height,
                  padding: const EdgeInsets.all(8),
                  child: TerminalInput(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
