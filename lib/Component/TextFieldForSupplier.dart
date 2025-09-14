import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controllers/home_controller.dart';
import '../const/colors.dart';
class DialogTextFieldSupplier extends StatelessWidget {
  const DialogTextFieldSupplier({
    super.key,

    this.onChangedFunc,
    required this.validationFunc,
    required this.text,
    required this.rowWidth,
    required this.textFieldWidth,
    required this.textEditingController,
    this.hint = '',
    this.isPassword = false,
    this.globalKey,
    this.read = false,
  });
  final Function(String)? onChangedFunc;
  final Function validationFunc;
  final String text;
  final String hint;
  final double rowWidth;
  final double textFieldWidth;
  final TextEditingController textEditingController;
  final bool isPassword;
  final GlobalKey? globalKey;
  final bool read;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return SizedBox(
      width: rowWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: rowWidth - textFieldWidth, child: Text(text)),
          SizedBox(
            width: textFieldWidth,
            child: TextFormField(
              key: globalKey,
              readOnly: read,
              cursorColor: Colors.black,
              obscureText: isPassword,
              controller: textEditingController,
              decoration: InputDecoration(
                // isDense: true,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
                contentPadding:
                homeController.isMobile.value
                    ? const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 10.0,
                )
                    : const EdgeInsets.fromLTRB(20, 15, 25, 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Primary.primary.withAlpha((0.2 * 255).toInt()),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Primary.primary.withAlpha((0.4 * 255).toInt()),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                ),
                errorStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
              ),
              validator: (value) {
                return validationFunc(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) => onChangedFunc!(value),
            ),
          ),
        ],
      ),
    );
  }
}
