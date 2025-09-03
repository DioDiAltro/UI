import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TerminalController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final RxList<String> output = <String>[].obs;

  static const Set<String> WINCOMMANDS = {'cls'};

  void cmd(String value) async {
    final command = value.trim().split(' ');

    if (command[0] == 'exit') {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
    } else if (['cls', 'clear'].contains(command[0])) {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        output.clear();
      }
    } else {
      output.add('>_: ${command[0]} non è riconosciuto nei sistemi');
    }

    inputController.clear();
  }
}

class TerminalInput extends StatelessWidget {
  final TerminalController controller = Get.put(TerminalController());

  TerminalInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.output.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                itemCount: controller.output.length,
                itemBuilder: (context, index) {
                  return Text(
                    controller.output[index],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        TextField(
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          controller: controller.inputController,
          maxLines: null,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: '>_:',
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          onSubmitted: controller.cmd,
        ),
      ],
    );
  }
}
