import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Backend/get_cities_of_a_specified_country.dart';
import '../../Backend/get_countries.dart';
import '../../Widgets/reusable_text_field.dart';
import '../../const/Sizes.dart';
import '../../const/colors.dart';
class Suppliers extends StatefulWidget {
  const Suppliers({super.key});

  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController floorBldgController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController jobPositionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController internalNoteController = TextEditingController();
  TextEditingController grantedDiscountController = TextEditingController();
  String selectedCountry = '', selectedCity = '';
  String selectedPhoneCode = '', selectedMobileCode = '';
  int selectedClientType = 1;
  int selectedTabIndex = 0;
  List tabsList = [
    'Settings',
    'Accounting',

  ];
  Map data = {};
  int selectedSupplierType = 1;
  List<String> titles = ['Doctor', 'Miss', 'Mister', 'Maitre', 'Professor'];
  String selectedTitle = '';
  bool isActiveInPosChecked = false;
  bool isBlockedChecked = false;
  final _formKey = GlobalKey<FormState>();
  List<String>acc = [];
  List<String> countriesNamesList = [];
  bool isCountriesFetched = false;
  List<String> citiesNamesList = [];
  bool isCitiesFetched = true;

  getCountriesFromBack() async {
    var p = await getCountries();
    setState(() {
      for (var c in p) {
        countriesNamesList.add('${c['country']}');
      }
      isCountriesFetched = true;
    });
  }

  getCitiesFromBack(String country) async {
    setState(() {
      isCitiesFetched = false;
      citiesNamesList = [];
    });
    var p = await getCitiesOfASpecifiedCountry(country);
    setState(() {
      for (var c in p) {
        citiesNamesList.add(c);
      }
      isCitiesFetched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCountriesFromBack();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create New Bloc",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Primary.primary)),

                gapH20,
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: ListTile(
                        title: const Text('Individual',
                            style: TextStyle(fontSize: 12)),
                        leading: Radio(
                          activeColor: Primary.primary,
                          value: 1,
                          groupValue: selectedSupplierType,
                          onChanged: (value) {
                            setState(() {
                              selectedSupplierType = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: ListTile(
                        title: const Text('Company',
                            style: TextStyle(fontSize: 12)),
                        leading: Radio(
                          activeColor: Primary.primary,
                          value: 2,
                          groupValue: selectedSupplierType,
                          onChanged: (value) {
                            setState(() {
                              selectedSupplierType = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                gapH16,
                const Text(
                  "SP000001",
                  style: TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                gapH16,

                DialogTextField(
                  textEditingController: supplierNameController,
                  text: '${'Bloc Name*'}*',
                  rowWidth: MediaQuery.of(context).size.width * 0.5,
                  textFieldWidth: MediaQuery.of(context).size.width * 0.4,
                  validationFunc: (value) {
                    if (value.isEmpty) {
                      return 'required field';
                    }
                    return null;
                  },
                ),
                gapH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DialogTextField(
                      textEditingController: referenceController,
                      text: 'Reference',
                      rowWidth: MediaQuery.of(context).size.width * 0.22,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.15,
                      validationFunc: (val) {},
                    ),
                    PhoneTextField(
                      textEditingController: phoneController,
                      text: 'Phone',
                      rowWidth: MediaQuery.of(context).size.width * 0.25,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.2,
                      validationFunc: (String val) {
                        if (val.isNotEmpty && val.length < 7) {
                          return '7_digits';
                        }
                        return null;
                      },
                      onCodeSelected: (value) {
                        setState(() {
                          selectedPhoneCode = value;
                        });
                      },
                      onChangedFunc: (value) {},
                    ),
                    DialogTextField(
                      textEditingController: floorBldgController,
                      text: 'Floor, Bldg',
                      rowWidth: MediaQuery.of(context).size.width * 0.22,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.15,
                      validationFunc: (val) {},
                    ),
                  ],
                ),

                gapH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Title'),
                          DropdownMenu<String>(
                            width: MediaQuery.of(context).size.width * 0.15,
                            // requestFocusOnTap: false,
                            enableSearch: true,
                            controller: searchController,
                            hintText: 'Doctor, Miss, Mister',
                            inputDecorationTheme: InputDecorationTheme(
                              // filled: true,
                              hintStyle: const TextStyle(
                                  fontStyle: FontStyle.italic),
                              contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 25, 5),
                              // outlineBorder: BorderSide(color: Colors.black,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Primary.primary.withAlpha((0.2 * 255).toInt()),
                                    width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(9)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Primary.primary.withAlpha((0.4 * 255).toInt()),
                                    width: 2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(9)),
                              ),
                            ),
                            // menuStyle: ,
                            menuHeight: 250,
                            dropdownMenuEntries: titles
                                .map<DropdownMenuEntry<String>>(
                                    (String option) {
                                  return DropdownMenuEntry<String>(
                                    value: option,
                                    label: option,
                                  );
                                }).toList(),
                            enableFilter: true,
                            onSelected: (String? val) {
                              setState(() {
                                selectedTitle = val!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    PhoneTextField(
                      textEditingController: mobileController,
                      text: 'Mobile',
                      rowWidth: MediaQuery.of(context).size.width * 0.25,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.2,
                      validationFunc: (val) {
                        if (val.isNotEmpty && val.length < 9) {
                          return '7_digits';
                        }
                        return null;
                      },
                      onCodeSelected: (value) {
                        setState(() {
                          selectedMobileCode = value;
                        });
                      }, onChangedFunc: (){},
                    ),
                    DialogTextField(
                      textEditingController: streetController,
                      text: 'Street',
                      rowWidth: MediaQuery.of(context).size.width * 0.22,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.15,
                      validationFunc: (val) {},
                    ),
                  ],
                ),
                gapH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DialogTextField(
                      textEditingController: jobPositionController,
                      text: 'Job Position',
                      hint: 'Sales Director,Sales...',
                      rowWidth: MediaQuery.of(context).size.width * 0.22,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.15,
                      validationFunc: (val) {},
                    ),
                    DialogTextField(
                      textEditingController: emailController,
                      text: 'Email',
                      hint: 'example@gmail.com',
                      rowWidth: MediaQuery.of(context).size.width * 0.25,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.2,
                      validationFunc: (String value) {
                        if (value.isNotEmpty &&
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'check_format';
                        }
                      },
                    ),
                    isCountriesFetched
                        ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('country'),
                          DropdownMenu<String>(
                            width: MediaQuery.of(context).size.width * 0.15,
                            // requestFocusOnTap: false,
                            enableSearch: true,
                            controller: countryController,
                            hintText: '',
                            inputDecorationTheme: InputDecorationTheme(
                              // filled: true,
                              hintStyle: const TextStyle(
                                  fontStyle: FontStyle.italic),
                              contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 25, 5),
                              // outlineBorder: BorderSide(color: Colors.black,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Primary.primary.withAlpha((0.2 * 255).toInt()),
                                    width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(9)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Primary.primary.withAlpha((0.4 * 255).toInt()),
                                    width: 2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(9)),
                              ),
                            ),
                            // menuStyle: ,
                            menuHeight: 250,
                            dropdownMenuEntries: countriesNamesList
                                .map<DropdownMenuEntry<String>>(
                                    (String option) {
                                  return DropdownMenuEntry<String>(
                                    value: option,
                                    label: option,
                                  );
                                }).toList(),
                            enableFilter: true,
                            onSelected: (String? val) {
                              setState(() {
                                selectedCountry = val!;
                                getCitiesFromBack(val);
                              });
                            },
                          ),
                        ],
                      ),
                    )
                        :SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      // child: loading()
                    ),
                  ],
                ),
                gapH10,



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DialogTextField(
                      textEditingController: taxNumberController,
                      text: 'tax number',
                      rowWidth: MediaQuery.of(context).size.width * 0.22,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.15,
                      validationFunc: (String val) {
                        if (selectedClientType == 2 && val.isEmpty) {
                          return 'required field';
                        }
                        return null;
                      },
                    ),
                    DialogTextField(
                      textEditingController: websiteController,
                      text: 'website',
                      hint: 'www.example.com',
                      rowWidth: MediaQuery.of(context).size.width * 0.25,
                      textFieldWidth:
                      MediaQuery.of(context).size.width * 0.2,
                      validationFunc: (String value) {
                        // if(value.isNotEmpty && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(value)) {
                        //   return 'check_format'.tr ;
                        // }return null;
                      },
                    ),

                    // CountryTextField(
                    //   onChangedFunc: (val){},
                    //   validationFunc:  (val){},
                    //   text: 'country'.tr,
                    //   rowWidth: MediaQuery.of(context).size.width*0.22,
                    //   textFieldWidth: MediaQuery.of(context).size.width * 0.15,
                    //   textEditingController: TextEditingController(),
                    //   onCodeSelected: (val) {
                    //     setState(() {
                    //       selectedCountry = val;
                    //     });
                    //   },),

                    isCitiesFetched
                        ?SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('city'.tr),
                          DropdownMenu<String>(
                            width: MediaQuery.of(context).size.width * 0.15,
                            // requestFocusOnTap: false,
                            enableSearch: true,
                            controller: cityController,
                            hintText: '',
                            inputDecorationTheme: InputDecorationTheme(
                              // filled: true,
                              hintStyle: const TextStyle(
                                  fontStyle: FontStyle.italic),
                              contentPadding:
                              const EdgeInsets.fromLTRB(20, 0, 25, 5),
                              // outlineBorder: BorderSide(color: Colors.black,),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Primary.primary.withAlpha((0.2 * 255).toInt()),
                                    width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(9)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Primary.primary.withAlpha((0.4 * 255).toInt()),
                                    width: 2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(9)),
                              ),
                            ),
                            // menuStyle: ,
                            menuHeight: 250,
                            dropdownMenuEntries: citiesNamesList
                                .map<DropdownMenuEntry<String>>(
                                    (String option) {
                                  return DropdownMenuEntry<String>(
                                    value: option,
                                    label: option,
                                  );
                                }).toList(),
                            enableFilter: true,
                            onSelected: (String? val) {
                              setState(() {
                                selectedCity = val!;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                        : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      // child: loading()
                    ),
                  ],
                ),
                gapH40,


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                        spacing: 0.0,
                        direction: Axis.horizontal,
                        children: tabsList
                            .map((element) => _buildTabChipItem(
                            element,
                            tabsList.indexOf(element)))
                            .toList()),
                  ],
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                        vertical: 25),
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6)),
                      color: Colors.white,
                    ),
                    child:
                    Column(children: [

                      selectedTabIndex == 0
                          ?     Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.29,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Granted Discount',
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.15,
                                  child: TextFormField(
                                    // textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(
                                          20, 0, 25, 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Primary.primary
                                                .withAlpha((0.2 * 255).toInt()),
                                            width: 1),
                                        borderRadius:
                                        const BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Primary.primary
                                                .withAlpha((0.4 * 255).toInt()),
                                            width: 2),
                                        borderRadius:
                                        const BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      errorStyle: const TextStyle(
                                        fontSize: 10.0,
                                      ),
                                      focusedErrorBorder:
                                      const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red),
                                      ),
                                    ),
                                    controller: grantedDiscountController,
                                    keyboardType: const TextInputType
                                        .numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]')),
                                      // WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          ,


                          gapH20,
                          Row(
                            children: [
                              Expanded(
                                  child: ListTile(
                                    title: const Text("Show in POS",
                                        style: TextStyle(fontSize: 12)),
                                    leading: Checkbox(
                                      activeColor: Primary.primary,
                                      value: isActiveInPosChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isActiveInPosChecked = value!;
                                        });
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          gapH10,
                          Row(
                            children: [
                              Expanded(
                                  child: ListTile(
                                    title: const Text('blocked',
                                        style: TextStyle(fontSize: 12)),
                                    leading: Checkbox(
                                      activeColor: Primary.primary,
                                      value: isBlockedChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isBlockedChecked = value!;
                                        });
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          gapH10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text('discard',
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.underline,
                                          color: Primary.primary))),
                              gapW24,
                              TextButton(
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    backgroundColor: WidgetStatePropertyAll(
                                        Primary.primary),
                                    foregroundColor:
                                    WidgetStateProperty.all<Color>(
                                        Primary.p0),
                                    overlayColor: WidgetStateProperty
                                        .resolveWith<Color?>(
                                          (Set<WidgetState> states) {
                                        if (states.contains(
                                            WidgetState.hovered)) {
                                          return Primary.p0
                                              .withAlpha((0.04 * 255).toInt());
                                        }
                                        if (states.contains(
                                            WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return Primary.primary
                                              .withAlpha((0.12 * 255).toInt());
                                        }
                                        return null; // Defer to the widget's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('    Save    ')),
                            ],
                          )
                        ],
                      )
                          : selectedTabIndex == 1
                          ?     Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.29,
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Account #',
                                ),

                              ],
                            ),
                          ),
                          gapH20,
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.29,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                // const Text(
                                //   'Account #',
                                // ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.15,
                                  child:   DropdownMenu<String>(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    // requestFocusOnTap: false,
                                    enableSearch: true,
                                    controller: countryController,
                                    hintText: '',
                                    inputDecorationTheme:
                                    InputDecorationTheme(
                                      // filled: true,
                                      hintStyle: const TextStyle(
                                          fontStyle: FontStyle.italic),
                                      contentPadding:
                                      const EdgeInsets.fromLTRB(
                                          20, 0, 25, 5),
                                      // outlineBorder: BorderSide(color: Colors.black,),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Primary.primary
                                                .withAlpha((0.2 * 255).toInt()),
                                            width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Primary.primary
                                                .withAlpha((0.4 * 255).toInt()),
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(9)),
                                      ),
                                    ),
                                    // menuStyle: ,
                                    menuHeight: 250,
                                    dropdownMenuEntries: acc
                                        .map<DropdownMenuEntry<String>>(
                                            (String option) {
                                          return DropdownMenuEntry<String>(
                                            value: option,
                                            label: option,
                                          );
                                        }).toList(),
                                    enableFilter: true,
                                    onSelected: (String? val) {
                                      setState(() {
                                        // selectedCountry = val!;
                                        // getCitiesFromBack(val);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          gapH100,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text('discard',
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.underline,
                                          color: Primary.primary))),
                              gapW24,
                              TextButton(
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    backgroundColor: WidgetStatePropertyAll(
                                        Primary.primary),
                                    foregroundColor:
                                    WidgetStateProperty.all<Color>(
                                        Primary.p0),
                                    overlayColor: WidgetStateProperty
                                        .resolveWith<Color?>(
                                          (Set<WidgetState> states) {
                                        if (states.contains(
                                            WidgetState.hovered)) {
                                          return Primary.p0
                                              .withAlpha((0.04 * 255).toInt());
                                        }
                                        if (states.contains(
                                            WidgetState.focused) ||
                                            states.contains(
                                                WidgetState.pressed)) {
                                          return Primary.primary
                                              .withAlpha((0.12 * 255).toInt());
                                        }
                                        return null; // Defer to the widget's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('    Save    ')),
                            ],
                          )
                        ],
                      )

                          :
                      const Text(".,")

                    ])

                ),




              ]),
        ),
      ),
    );
  }
  Widget _buildTabChipItem(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: ClipPath(
        clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9)))),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.height * 0.07,
          // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color: selectedTabIndex == index ? Primary.p20 : Colors.white,
              border: selectedTabIndex == index
                  ? Border(
                top: BorderSide(color: Primary.primary, width: 3),
              )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                  spreadRadius: 9,
                  blurRadius: 9,
                  offset: const Offset(0, 3),
                )
              ]),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Primary.primary),
            ),
          ),
        ),
      ),
    );
  }
}
