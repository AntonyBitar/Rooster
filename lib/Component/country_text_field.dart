import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
class CountryTextField extends StatefulWidget {
  const CountryTextField({
    super.key,
    required this.onChangedFunc,
    required this.validationFunc,
    required this.text,
    required this.rowWidth,
    required this.textFieldWidth,
    required this.textEditingController,
    this.hint = '',
    required this.onCodeSelected,
  });
  final Function onChangedFunc;
  final Function validationFunc;
  final Function onCodeSelected;
  final String text;
  final String hint;
  final double rowWidth;
  final double textFieldWidth;
  final TextEditingController textEditingController;

  @override
  State<CountryTextField> createState() => _CountryTextFieldState();
}

class _CountryTextFieldState extends State<CountryTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.rowWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text),
          SizedBox(
            width: widget.textFieldWidth,
            child: TextFormField(
              cursorColor: Colors.black,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 25, 5),
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
                errorStyle: const TextStyle(fontSize: 10.0),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
              ),
              onTap: () {
                showCountryPicker(
                  context: context,
                  // showPhoneCode: true, // optional. Shows phone code before the country name.
                  onSelect: (country) {},
                );
                // widget.onChangedFunc(value);
              },
              onChanged: (value) => widget.onChangedFunc(value),
            ),
          ),
        ],
      ),
    );
  }
}