import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TerminalController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final RxList<String> output = <String>[].obs;

  // static const Set<String> WINCOMMANDS = {'cls'};

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
  final FocusNode _focusNode = FocusNode();

  TerminalInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        height: Get.height,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(() {
              if (controller.output.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.output.length,
                  itemBuilder: (context, index) {
                    return Text(
                      controller.output[index],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              controller: controller.inputController,
              focusNode: _focusNode,
              autofocus: true,
              maxLines: null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Text(
                  '>_:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onSubmitted: controller.cmd,
            ),
          ],
        ),
      ),
    );
  }
}
