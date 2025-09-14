import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:rooster_app/Screens/Supplier/add_new_supplier.dart';

import '../Wrapper/StringWrapper.dart';
class PhoneDialog {
  static Future<void> show(BuildContext context,TextEditingController Number,StringWrapper phoneCode,StringWrapper number) async {
    String completePhoneNumber='';
    final GlobalKey<FormState> _formKey = GlobalKey();
    await showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text("Enter Phone Number"),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                initialCountryCode: 'LB',
                pickerDialogStyle: PickerDialogStyle(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                onChanged: (phone) {
                  if(phone.isValidNumber()){
                    phoneCode.value=phone.countryCode;
                    number.value=phone.number;
                    completePhoneNumber=phone.completeNumber;
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed:() {
                  if(_formKey.currentState!.validate()){
                  Number.text=completePhoneNumber;
                  Navigator.pop(context);
                }},
                child: const Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }
}