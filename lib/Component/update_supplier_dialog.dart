import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Component/contacts_and_addresses_section.dart';
import 'package:rooster_app/Component/phone_number_dialog_picker.dart';
import 'package:rooster_app/Component/phone_number_text_field.dart';
import 'package:rooster_app/Models/Supplier/SupplierAddressModel.dart';
import 'package:rooster_app/Models/Supplier/SupplierModel.dart';

import '../Backend/ClientsBackend/get_client_create_info.dart';
import '../Backend/ClientsBackend/update_client.dart';
import '../Backend/get_cities_of_a_specified_country.dart';
import '../Backend/get_countries.dart';
import '../Blocs/City/Bloc/CityBloc.dart';
import '../Blocs/City/Events/CityEvent.dart';
import '../Blocs/City/States/CityStates.dart';
import '../Blocs/Countries/Bloc/CountryBloc.dart';
import '../Blocs/Countries/Events/CountryEvent.dart';
import '../Blocs/Countries/States/CountryStates.dart';
import '../Blocs/Supplier/Bloc/SupplierBloc.dart';
import '../Blocs/Supplier/Events/SupplierEvent.dart';
import '../Blocs/SupplierCreation/Bloc/SupplierBloc.dart';
import '../Blocs/SupplierCreation/States/SupplierStates.dart';
import '../Controllers/client_controller.dart';
import '../Controllers/home_controller.dart';
import '../Cubits/CheckBoxStates.dart';
import '../Locale_Memory/save_user_info_locally.dart';
import '../Models/City/CityModel.dart';
import '../Models/Company/CompanyModel.dart';
import '../Models/Country/CountryModel.dart';
import '../Models/PaymentTerm/PaymentTermModel.dart';
import '../Widgets/custom_snak_bar.dart';
import '../Widgets/dialog_drop_menu.dart';
import '../Widgets/loading.dart';
import '../Widgets/page_title.dart';
import '../Widgets/reusable_btn.dart';
import '../Widgets/reusable_text_field.dart';
import '../Wrapper/StringWrapper.dart';
import '../const/Sizes.dart';
import '../const/colors.dart';
import 'TextFieldForSupplier.dart';

class UpdateSupplierDialog extends StatefulWidget {
   UpdateSupplierDialog({
    super.key,
    required this.supplier,
  });
  Supplier supplier;

  @override
  State<UpdateSupplierDialog> createState() => _UpdateClientDialogState();
}

class _UpdateClientDialogState extends State<UpdateSupplierDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController priceListController = TextEditingController();
  TextEditingController supplierNameController = TextEditingController();
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
  final HomeController homeController = Get.find();

  String paymentTerm = '',
      selectedPriceListId = '';
  StringWrapper selectedPhone=StringWrapper("");
  StringWrapper selectedMobile=StringWrapper( "");
  StringWrapper selectedPhoneCode=StringWrapper( "");
  StringWrapper selectedMobileCode=StringWrapper( "");
  int selectedClientType = 1;
  int selectedTabIndex = 0;
  // List tabsList = [
  //   // 'contacts_addresses',
  //   // 'sales',
  //   // 'internal_note',
  //   'settings',
  // ];

  ClientController clientController = Get.find();

  List<String> titles = ['Doctor', 'Miss', 'Mister', 'Maitre', 'Professor'];
  String selectedTitle = '';
  String countryValue = "";
  String recentSearchKey = '-1';
  String stateValue = "";
  String cityValue = "";

  List<String> countriesNamesList = [];
  List<String> citiesNamesList = [];
  List<SupplierAddress>supplierAddresses=[];
  List<String> pricesListsNames=[];
  List<String> pricesListsCodes=[];
  List<String> pricesListsIds=[];

  List tabsList = [
    'settings',
    'contacts_and_addresses',
  ];
  @override
  void initState() {

    selectedClientType = 1;
    supplierNameController.text = widget.supplier.name ?? '';
    internalNoteController.text = widget.supplier.note ?? '';
    grantedDiscountController.text = '${widget.supplier.grantedDiscount ?? ''}';
    if (widget.supplier.city != null) {
      countryController.text = widget.supplier.city!.country?.name ?? '';
      countryValue = widget.supplier.city!.country?.name ?? '';
    } else {
      countryController.text = widget.supplier.country?.name ?? '';
      countryValue = widget.supplier.country?.name ?? '';
    }
    cityController.text =widget.supplier.city?.name ?? '';
    cityValue =widget.supplier.city?.name ?? '';
    floorBldgController.text = widget.supplier.floorAndBuilding??'';
    streetController.text = widget.supplier.street??'';
    jobPositionController.text = widget.supplier.jobPosition??'';
    emailController.text = widget.supplier.email??'';
    titleController.text = widget.supplier.title??'';
    selectedTitle = widget.supplier.title??'';
    //stateValue = widget.info['state'] ?? '';
    websiteController.text =widget.supplier.website??'';
    supplierAddresses = widget.supplier.supplierAddress!.map((u) => u.copy()).toList();
    titleController.text = widget.supplier.title??'';
    referenceController.text = widget.supplier.reference??'';
    phoneController.text = (widget.supplier.phoneCode ?? '') + (widget.supplier.phoneNumber ?? '');
    selectedMobile.value=widget.supplier.mobileNumber??'';
    selectedPhoneCode.value = widget.supplier.phoneCode??'';
    selectedPhone.value = widget.supplier.phoneNumber??'';
    mobileController.text = (widget.supplier.mobileCode ?? '') + (widget.supplier.mobileNumber ?? '');
    selectedMobileCode.value = widget.supplier.mobileCode??'';
    taxNumberController.text = widget.supplier.taxId??'';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PageTitle(text: 'update_client'.tr),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                            backgroundColor: Primary.primary,
                            radius: 15,
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // gapH32,
                    // const AddPhotoCircle(),
                    gapH32,
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width * 0.15,
                    //       child: ListTile(
                    //         title: Text(
                    //           'individual'.tr,
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         leading: Radio(
                    //           value: 1,
                    //           groupValue: selectedClientType,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               selectedClientType = value!;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width * 0.15,
                    //       child: ListTile(
                    //         title: Text(
                    //           'company'.tr,
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         leading: Radio(
                    //           value: 2,
                    //           groupValue: selectedClientType,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               selectedClientType = value!;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    gapH10,
                    Text(
                      widget.supplier.supplierNumber ?? '',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH10,
                    DialogTextFieldSupplier(
                      onChangedFunc: (v){},

                      textEditingController: supplierNameController,
                      text: '${'client_name'.tr}*',
                      rowWidth: MediaQuery.of(context).size.width * 0.5,
                      textFieldWidth: MediaQuery.of(context).size.width * 0.4,
                      validationFunc: (val) {
                        if (val.isEmpty) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                    ),
                    gapH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},

                          textEditingController: referenceController,
                          text: 'reference'.tr,
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.15,
                          validationFunc: (val) {},
                        ),
                        PhoneDialogTextField(
                          onChangedFunc: (v){},

                          read: true,
                          text: 'phone'.tr,
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textEditingController: phoneController,
                          textFieldWidth:  MediaQuery.of(context).size.width * 0.2,
                          onTap: () {
                            PhoneDialog.show(context, phoneController,selectedPhoneCode,selectedPhone);
                          },
                        ),
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},

                          textEditingController: floorBldgController,
                          text: 'floor_bldg'.tr,
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.15,
                          validationFunc: (val) {},
                        ),
                      ],
                    ),
                    gapH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('title'.tr),
                              DropdownMenu<String>(
                                width: MediaQuery.of(context).size.width * 0.15,
                                // requestFocusOnTap: false,
                                enableSearch: true,
                                controller: titleController,
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
                                    selectedTitle = val!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        PhoneDialogTextField(
                          onChangedFunc: (v){},
                          onValidateFunc:(value) {
                            if (value.isEmpty) return 'required_field'.tr;
                            return null;
                          },
                          read: true,
                          text: '${'mobile'.tr}*',
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textEditingController: mobileController,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.2,
                          onTap: () {
                            PhoneDialog.show(context, mobileController,selectedMobileCode,selectedMobile);
                          },
                        ),
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},

                          textEditingController: streetController,
                          text: 'street'.tr,
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.15,
                          validationFunc: (val) {},
                          // onChangedFunc: (value){
                          //   setState(() {
                          //      mainDescriptionController.text=value;
                          //   });
                          // },
                        ),
                      ],
                    ),
                    gapH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},

                          textEditingController: jobPositionController,
                          text: 'job_position'.tr,
                          hint: 'Sales Director,Sales...',
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.15,
                          validationFunc: (val) {},
                        ),
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},

                          textEditingController: emailController,
                          text:'${'email'.tr}*',

                          hint: 'example@gmail.com',
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.2,
                          validationFunc: (String value) {
                            if (value.isEmpty) return 'required_field'.tr;
                            if (value.isNotEmpty &&
                                !RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ).hasMatch(value)) {
                              return 'check_format'.tr;
                            }
                          },
                        ),
                         SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('country'.tr),
                              BlocBuilder<CountryBloc, CountryState>(
                                builder: (context, state) {
                                  if (state is CountryInitial) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.15,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Primary.primary.withAlpha(
                                                  (0.2 * 255).toInt(),
                                                ),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                9,
                                              ),
                                            ),
                                            child:
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.15,
                                              child: DropdownSearch<Country>(
                                                selectedItem: (context.read<CountryBloc>().state as CountryLoadSuccess).country?? Country(),
                                                onChanged: (value)async{
                                                  final countryState = context.read<CountryBloc>().state as CountryLoadSuccess;
                                                  countryState.country=value!;
                                                  final cBloc = context.read<CitiesBloc>();
                                                  //await cBloc.stream.firstWhere((s) => s is CitiesLoadSuccess);
                                                  cBloc.add(LoadCities(countryId: -1,search: ''));

                                                  //final cityState = context.read<CitiesBloc>().state as CitiesLoadSuccess;
                                                  //cityState.cities=[];
                                                  widget.supplier.city=null;

                                                },

                                                itemAsString: (c) => c.name ?? '',
                                                compareFn:(Country? a, Country? b) => a?.id == b?.id,
                                                items: (String filter, LoadProps? load) async {
                                                  final cBloc = context.read<CountryBloc>();
                                                  final take = load?.take ?? 15;
                                                  final skip = load?.skip ?? 0;
                                                  final page = (skip ~/ take) + 1;
                                                  final isSearch = filter.isNotEmpty;
                                                  cBloc.add(
                                                    LoadCountryCreation(
                                                      selectedCountry:(context.read<CountryBloc>().state as CountryLoadSuccess).country
                                                          ?? widget.supplier.city?.country
                                                          ?? widget.supplier.country
                                                          ?? Country(),
                                                      search: filter,
                                                      page: page,
                                                      reset: isSearch || (recentSearchKey != filter),
                                                    ),
                                                  );
                                                  final s = await cBloc.stream.firstWhere((s) => s is CountryLoadSuccess)
                                                  as CountryLoadSuccess;
                                                  final all = s.countries;
                                                  final chunk = (all.length > skip) ? all.skip(skip).take(take).toList() : <Country>[];

                                                  recentSearchKey = filter;
                                                  return chunk;
                                                },
                                                popupProps: PopupProps.menu(
                                                  loadingBuilder: (context, widget) {
                                                    return Container(
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      child: const CircularProgressIndicator(strokeWidth: 2),
                                                    );
                                                  },
                                                  showSearchBox: true,
                                                  disableFilter: true,
                                                  searchFieldProps: TextFieldProps(
                                                    decoration: InputDecoration(
                                                      hintText: 'Search...',
                                                      prefixIcon: Icon(Icons.search, size: 20),
                                                      isDense: true,
                                                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                                                      ),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                    ),
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                  infiniteScrollProps: InfiniteScrollProps(
                                                    loadProps: const LoadProps(take: 15),
                                                  ),
                                                ),

                                                decoratorProps: const DropDownDecoratorProps(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                  }
                                },
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                    gapH10,
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},
                          textEditingController: taxNumberController,
                          text: 'tax_number'.tr,
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.15,
                          validationFunc: (val) {
                            if (selectedClientType == 2 && val.isEmpty) {
                              return 'required_field'.tr;
                            }
                            return null;
                          },
                        ),
                        DialogTextFieldSupplier(
                          onChangedFunc: (v){},

                          textEditingController: websiteController,
                          text: 'website'.tr,
                          hint: 'www.example.com',
                          rowWidth: MediaQuery.of(context).size.width * 0.25,
                          textFieldWidth: MediaQuery.of(context).size.width * 0.2,
                          validationFunc: (String value) {
                            if(value.isEmpty)return null;
                            final urlPattern = r'^(https?:\/\/)?([\w\-])+\.{1}([a-zA-Z]{2,63})([\/\w\.-]*)*\/?$';
                            final regex = RegExp(urlPattern);
                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid website URL';
                            }
                            return null; // valid
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: BlocBuilder<CitiesBloc, CitiesState>(
                            builder: (context, state) {
                              if (state is CitiesLoading) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('city'.tr),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state is CitiesLoadSuccess) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('city'.tr),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Primary.primary.withAlpha(
                                            (0.2 * 255).toInt(),
                                          ),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: DropdownSearch<City>(
                                          selectedItem:(context.read<CitiesBloc>().state as CitiesLoadSuccess).selectedCity??widget.supplier.city??City(),
                                        itemAsString: (c) => c.name ?? '',
                                        compareFn: (City? a, City? b) => a?.id == b?.id,
                                        items: (String filter, LoadProps? load) async {
                                          final cityBloc = context.read<CitiesBloc>();
                                          (cityBloc.state as CitiesLoadSuccess).cities=[];
                                          final take = load?.take ?? 15;
                                          final skip = load?.skip ?? 0;
                                          final page = (skip ~/ take) + 1;
                                          final countryBloc = context.read<CountryBloc>();
                                          final isSearch = filter.isNotEmpty;
                                          cityBloc.add(
                                            LoadCities(
                                              search: filter,
                                              page: page,
                                              countryId: (countryBloc.state as CountryLoadSuccess).country != null
                                                  ? (countryBloc.state as CountryLoadSuccess).country!.id!
                                                  : (widget.supplier.city != null
                                                  ? widget.supplier.city!.country!.id
                                                  : (widget.supplier.country != null
                                                  ? widget.supplier.country!.id
                                                  : -1)),
                                              reset: isSearch || (recentSearchKey != filter),
                                            ),
                                          );

                                          final s = await cityBloc.stream.firstWhere((s) => s is CitiesLoadSuccess) as CitiesLoadSuccess;
                                          final all = s.cities;
                                          final chunk = (all.length > skip) ? all.skip(skip).take(take).toList() : <City>[];
                                          recentSearchKey = filter;
                                          return chunk;
                                        },
                                        onChanged: (City? value) {
                                          (context.read<CitiesBloc>().state as CitiesLoadSuccess).selectedCity = value;
                                        },
                                        popupProps: PopupProps.menu(
                                          loadingBuilder: (context, widget) {
                                            return Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              child: const CircularProgressIndicator(strokeWidth: 2),
                                            );
                                          },
                                          showSearchBox: true,
                                          disableFilter: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                              prefixIcon: Icon(Icons.search, size: 20),
                                              isDense: true,
                                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          infiniteScrollProps: InfiniteScrollProps(
                                            loadProps: const LoadProps(take: 15),
                                          ),
                                        ),
                                        decoratorProps: const DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('city'.tr),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                                ],
                              );
                            },
                          ),
                        ),


                      ],
                    ),
                    gapH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 0.0,
                          direction: Axis.horizontal,
                          children:
                          tabsList
                              .map(
                                (element) => _buildTabChipItem(
                              element,
                              // element['id'],
                              // element['name'],
                              tabsList.indexOf(element),
                            ),
                          )
                              .toList(),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                        vertical: 25,
                      ),
                      height: 560,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          selectedTabIndex == 0
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableInputNumberField(
                                controller: grantedDiscountController,
                                textFieldWidth:
                                MediaQuery.of(context).size.width *
                                    0.15,
                                rowWidth:
                                MediaQuery.of(context).size.width *
                                    0.25,
                                onChangedFunc: (val) {},
                                validationFunc: (value) {},
                                text: 'granted_discount'.tr,
                              ),
                              gapH20,
                              Row(
                                children: [
                                  Expanded(
                                      child: BlocBuilder<CheckBoxCubit, Map<String, bool>>(
                                        builder: (context, state) {
                                          return ListTile(
                                            title: Text(
                                              'show_in_POS'.tr,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            leading: Checkbox(
                                              value:context.read<CheckBoxCubit>().getValue("show_in_POS"),
                                              onChanged: (_) {
                                                context.read<CheckBoxCubit>().toggle('show_in_POS'); // toggle the specific key
                                              },
                                            ),
                                          );
                                        },
                                      )


                                  ),
                                ],
                              ),

                              gapH20,
                              Row(
                                children: [
                                  Expanded(
                                      child: BlocBuilder<CheckBoxCubit, Map<String, bool>>(
                                        builder: (context, state) {
                                          return ListTile(
                                            title: Text(
                                              'blocked'.tr,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            leading: Checkbox(
                                              onChanged: (_) {
                                                context.read<CheckBoxCubit>().toggle('blocked');
                                              }, value: context.read<CheckBoxCubit>().getValue("blocked")
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ],
                              )
                            ],
                          ): ContactsAndAddressesSection(supplierAddresses:supplierAddresses,),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
            )
                ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<CheckBoxCubit>(context, listen: false).resetAll();
                    BlocProvider.of<CountryBloc>(context, listen: false).add(ResetCountry());
                    BlocProvider.of<CitiesBloc>(context, listen: false).add(ResetCity());
                    widget.supplier.country=null;
                    widget.supplier.city=null;
                    setState(() {
                      selectedClientType = 1;
                      selectedPhoneCode.value= '';
                      selectedMobileCode .value= '';
                      grantedDiscountController.clear();
                      supplierNameController.clear();
                      referenceController.clear();
                      websiteController.clear();
                      phoneController.clear();
                      floorBldgController.clear();
                      titleController.clear();
                      mobileController.clear();
                      taxNumberController.clear();
                      cityController.clear();
                      countryController.clear();
                      emailController.clear();
                      jobPositionController.clear();
                      streetController.clear();
                      grantedDiscountController.clear();
                    });
                  },
                  child: Text(
                    'discard'.tr,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Primary.primary,
                    ),
                  ),
                ),
                gapW24,
                ReusableButtonWithColor(
                  btnText: 'save'.tr,
                  onTapFunction: () async {
                    if (_formKey.currentState!.validate()) {
                      String companyId=await getCompanyIdFromPref();
                      String companyName=await getCompanyNameFromPref();
                      String supplierNumber= widget.supplier.supplierNumber!;
                      City? supplierCity= ((context.read<CitiesBloc>()).state as CitiesLoadSuccess).selectedCity;
                      Country? selectedCountry= ((context.read<CountryBloc>()).state as CountryLoadSuccess).country;
                      bool? showInPOS=context.read<CheckBoxCubit>().state["show_in_POS"];
                      bool? isBlocked=context.read<CheckBoxCubit>().state["blocked"];
                      widget.supplier=Supplier(id: widget.supplier.id,name: supplierNameController.text,company: Company(id:int.parse(companyId.toString()),name:companyName),supplierNumber:supplierNumber,type:"indivisual",city:supplierCity??widget.supplier.city,street: streetController.text,floorAndBuilding: floorBldgController.text,jobPosition: jobPositionController.text,phoneCode: selectedPhoneCode.value,phoneNumber: selectedPhone.value,mobileCode: selectedMobileCode.value,mobileNumber: selectedMobile.value,reference: referenceController.text,email: emailController.text,title:titleController.text,taxId:taxNumberController.text,website: websiteController.text,paymentTerm: PaymentTerm(id:1),note: "asd",active:true,grantedDiscount:double.tryParse(grantedDiscountController.text.toString()),showOnPos: showInPOS,isBlocked: isBlocked,isCashCustomer:false,autoGeneratedNumber: true,supplierAddress: supplierAddresses,country: selectedCountry??widget.supplier.country);
                      (context.read<SuppliersBloc>()).add(UpdateSupplier(supplier: widget.supplier));
                      Navigator.pop(context);
                    }
                  },
                  width: 100,
                  height: 35,
                ),
              ],
            ),
          ),
    ],
    ));
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
              topRight: Radius.circular(9),
            ),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.height * 0.07,
          // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
            color: selectedTabIndex == index ? Primary.p20 : Colors.white,
            border:
            selectedTabIndex == index
                ? Border(top: BorderSide(color: Primary.primary, width: 3))
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                spreadRadius: 9,
                blurRadius: 9,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              name.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Primary.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}