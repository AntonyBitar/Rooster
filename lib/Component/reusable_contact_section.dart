import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Component/phone_number_dialog_picker.dart';
import 'package:rooster_app/Component/phone_number_text_field.dart';
import 'package:rooster_app/Models/Supplier/SupplierAddressModel.dart';
import '../Controllers/client_controller.dart';
import '../Controllers/home_controller.dart';
import '../Screens/Client/add_new_client.dart';
import '../Widgets/reusable_text_field.dart';
import '../Wrapper/StringWrapper.dart';
import '../const/Sizes.dart';
import '../const/colors.dart';
import 'TextFieldForSupplier.dart';
class ReusableContactSectionSupplier extends StatefulWidget {
  const ReusableContactSectionSupplier({super.key, required this.supplierAddress,required this.onRemove,});
  final SupplierAddress supplierAddress;
  final VoidCallback onRemove;

  @override
  State<ReusableContactSectionSupplier> createState() => _ReusableContactSectionState();
}

class _ReusableContactSectionState extends State<ReusableContactSectionSupplier> {
  ClientController clientController = Get.find();
  String selectedContactsPhoneCode = '', selectedContactsMobileCode = '';
  int selectedContactAndAddressType = 1;
  String selectedContactsTitle = '';

  TextEditingController contactsNameController = TextEditingController();
  TextEditingController contactsPhoneController = TextEditingController();
  TextEditingController contactsTitleController = TextEditingController();
  TextEditingController contactsMobileController = TextEditingController();
  TextEditingController contactsJobPositionController = TextEditingController();
  TextEditingController contactsAddressController = TextEditingController();
  TextEditingController contactsEmailController = TextEditingController();
  TextEditingController contactsNoteController = TextEditingController();
  TextEditingController contactsExtController = TextEditingController();
  StringWrapper selectedPhone=StringWrapper( "");
  StringWrapper selectedPhoneCode=StringWrapper( "");
  StringWrapper selectedMobile=StringWrapper( "");
  StringWrapper selectedMobileCode=StringWrapper( "");

  @override
  void initState() {
    selectedContactAndAddressType=widget.supplierAddress.type!=null?widget.supplierAddress.type=="1"?1:2:1;
    selectedContactsPhoneCode =widget.supplierAddress.phoneCode??'+961';
    selectedContactsMobileCode =widget.supplierAddress.mobileCode??'+961';
    contactsNameController.text =widget.supplierAddress.name??'';
    contactsTitleController.text =widget.supplierAddress.title??'';
    selectedContactsTitle =widget.supplierAddress.title??'';
    contactsPhoneController.text =(widget.supplierAddress.phoneCode??'')+(widget.supplierAddress.phoneNumber??'');
    contactsMobileController.text =(widget.supplierAddress.mobileCode??'')+(widget.supplierAddress.mobileNumber??'');
    contactsJobPositionController.text =widget.supplierAddress.jobPosition??'';
    contactsAddressController.text =widget.supplierAddress.deliveryAddress??'';
    contactsEmailController.text =widget.supplierAddress.email??'';
    contactsNoteController.text =widget.supplierAddress.internalNote??'';
    contactsExtController.text =widget.supplierAddress.extension??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Primary.primary.withAlpha((0.2 * 255).toInt()),
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Selection used to add the contact information of personnel within the company (e.g., CEO, CFO, ...).',
              ),
              gapH28,
              GetBuilder<HomeController>(
                  builder: (homeCont) {
                    double miniRowWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.19:MediaQuery.of(context).size.width * 0.25;
                    double smallRowWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.22:MediaQuery.of(context).size.width * 0.27;
                    double smallTextFieldWidth=homeCont.isMenuOpened?
                    MediaQuery.of(context).size.width * 0.15
                        : MediaQuery.of(context).size.width * 0.19;
                    double middleRowWidth=homeCont.isMenuOpened? MediaQuery.of(context).size.width * 0.25:MediaQuery.of(context).size.width * 0.29;
                    double middleTextFieldWidth=homeCont.isMenuOpened?
                    MediaQuery.of(context).size.width * 0.2
                        : MediaQuery.of(context).size.width * 0.25;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DialogTextFieldSupplier(
                              textEditingController: contactsNameController,
                              text: 'name'.tr,
                              rowWidth:smallRowWidth,
                              textFieldWidth:smallTextFieldWidth,
                              validationFunc: (val) {},
                              onChangedFunc: (val) {
                                widget.supplierAddress.name=val;
                                //cont.updateContactName(widget.index, val);
                              },
                            ),
                            PhoneDialogTextField(
                              read: true,
                              text: 'phone'.tr,
                              rowWidth: middleRowWidth,
                              textEditingController: contactsPhoneController,
                              textFieldWidth: middleTextFieldWidth,
                              onTap: () async{
                                await PhoneDialog.show(context, contactsPhoneController,selectedPhoneCode,selectedPhone);
                                widget.supplierAddress.phoneCode=selectedPhoneCode.value;
                                widget.supplierAddress.phoneNumber=selectedPhone.value;

                              },
                            ),
                            DialogTextFieldSupplier(
                              validationFunc: (val) {
                                if (val == null || val.isEmpty) {
                                  return null; // allow empty if not mandatory
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                                  return 'Extension must contain digits only';
                                }
                                if (val.length > 11) {
                                  return 'Cannot be longer than 11 digits';
                                }
                                return null;
                              },
                              textEditingController: contactsExtController,
                              text: 'ext'.tr,
                              rowWidth: miniRowWidth,
                              textFieldWidth: smallTextFieldWidth,
                              onChangedFunc: (val) {
                                widget.supplierAddress.extension=val;
                              },
                            ),
                          ],
                        ),
                        gapH10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: smallRowWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('title'.tr),
                                  DropdownMenu<String>(
                                    width: smallTextFieldWidth,
                                    // requestFocusOnTap: false,
                                    enableSearch: true,
                                    controller: contactsTitleController,
                                    hintText: 'Doctor, Miss, Mister',
                                    inputDecorationTheme: InputDecorationTheme(
                                      // filled: true,
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        20,
                                        0,
                                        25,
                                        5,
                                      ),
                                      // outlineBorder: BorderSide(color: Colors.black,),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Primary.primary.withAlpha(
                                            (0.2 * 255).toInt(),
                                          ),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(9),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Primary.primary.withAlpha(
                                            (0.4 * 255).toInt(),
                                          ),
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(9),
                                        ),
                                      ),
                                    ),
                                    // menuStyle: ,
                                    menuHeight: 250,
                                    dropdownMenuEntries:
                                    titles.map<DropdownMenuEntry<String>>((
                                        String option,
                                        ) {
                                      return DropdownMenuEntry<String>(
                                        value: option,
                                        label: option,
                                      );
                                    }).toList(),
                                    enableFilter: true,
                                    onSelected: (String? val) {
                                      setState(() {
                                        selectedContactsTitle = val!;
                                      });
                                      widget.supplierAddress.title=val;
                                      //cont.updateContactTitle(widget.index, val!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            PhoneDialogTextField(
                              read: true,
                              text: 'mobile'.tr,
                              rowWidth: middleRowWidth,
                              textEditingController: contactsMobileController,
                              textFieldWidth: middleTextFieldWidth,
                              onTap: ()async {
                                await PhoneDialog.show(context, contactsMobileController,selectedMobileCode,selectedMobile);
                                widget.supplierAddress.mobileNumber=selectedMobile.value;
                                widget.supplierAddress.mobileCode=selectedMobileCode.value;

                              },
                            ),
                            DialogTextFieldSupplier(
                              textEditingController: contactsAddressController,
                              text: 'address'.tr,
                              rowWidth: miniRowWidth,
                              textFieldWidth: smallTextFieldWidth,
                              validationFunc: (val) {},
                              onChangedFunc: (val) {
                                widget.supplierAddress.deliveryAddress=val;
                                //cont.updateContactDeliveryAddress(widget.index, val);
                              },
                            ),
                          ],
                        ),
                        gapH10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DialogTextFieldSupplier(
                              textEditingController: contactsJobPositionController,
                              text: 'job_position'.tr,
                              hint: 'Sales Director,Sales...',
                              rowWidth:smallRowWidth,
                              textFieldWidth:smallTextFieldWidth,
                              validationFunc: (val) {},
                              onChangedFunc: (val) {
                                widget.supplierAddress.jobPosition=val;
                                //cont.updateContactJobPosition(widget.index, val);
                              },
                            ),
                            DialogTextFieldSupplier(
                              textEditingController: contactsEmailController,
                              text: 'email'.tr,
                              hint: 'example@gmail.com',
                              rowWidth:middleRowWidth,
                              textFieldWidth:middleTextFieldWidth,
                              validationFunc: (String value) {
                                if (value.isNotEmpty &&
                                    !RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                    ).hasMatch(value)) {
                                  return 'check_format'.tr;
                                }
                              },
                              onChangedFunc: (val) {
                                widget.supplierAddress.email=val;
                                //cont.updateContactEmail(widget.index, val);
                              },
                            ),
                            SizedBox(width: miniRowWidth),
                          ],
                        ),
                      ],
                    );
                  }
              ),
              gapH48,
              TextField(
                controller: contactsNoteController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'note.....',
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Primary.primary.withAlpha((0.2 * 255).toInt()),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Primary.primary.withAlpha((0.2 * 255).toInt()),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      width: 1,
                      color: Primary.primary.withAlpha((0.4 * 255).toInt()),
                    ),
                  ),
                ),
                onChanged: (val) {
                  widget.supplierAddress.internalNote=val;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onRemove,
                ),
              )
            ],
          ),
    );
  }
}