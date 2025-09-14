import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rooster_app/Blocs/City/Events/CityEvent.dart';
import 'package:rooster_app/Blocs/Countries/Bloc/CountryBloc.dart';
import 'package:rooster_app/Blocs/Countries/Events/CountryEvent.dart';
import 'package:rooster_app/Blocs/Countries/States/CountryStates.dart';
import 'package:rooster_app/Blocs/Supplier/Bloc/SupplierBloc.dart';
import 'package:rooster_app/Models/City/CityModel.dart';
import 'package:rooster_app/Models/Company/CompanyModel.dart';
import 'package:rooster_app/Models/Country/CountryModel.dart';
import 'package:rooster_app/Models/PaymentTerm/PaymentTermModel.dart';
import 'package:rooster_app/Models/Supplier/SupplierModel.dart';
import 'package:rooster_app/Screens/Configuration/taxation_groups_dialog.dart';
import '../../Blocs/City/Bloc/CityBloc.dart';
import '../../Blocs/City/States/CityStates.dart';
import '../../Blocs/Supplier/Events/SupplierEvent.dart';
import '../../Blocs/Supplier/States/SupplierStates.dart';
import '../../Blocs/SupplierCreation/Bloc/SupplierBloc.dart';
import '../../Blocs/SupplierCreation/States/SupplierStates.dart';
import '../../Component/TextFieldForSupplier.dart';
import '../../Component/contacts_and_addresses_section.dart';
import '../../Component/phone_number_dialog_picker.dart';
import '../../Component/phone_number_text_field.dart';
import '../../Component/reusable_button_with_color.dart';
import '../../Controllers/home_controller.dart';
import '../../Cubits/CheckBoxStates.dart';
import '../../Locale_Memory/save_user_info_locally.dart';
import '../../Widgets/custom_snak_bar.dart';
import '../../Widgets/page_title.dart';
import '../../Widgets/reusable_btn.dart';
import '../../Widgets/reusable_text_field.dart';
import '../../Wrapper/StringWrapper.dart';
import '../../const/Sizes.dart';
import '../../const/colors.dart';

List<String> titles = ['Doctor', 'Miss', 'Mister', 'Maitre', 'Professor'];

class AddNewSupplier extends StatefulWidget {
  const AddNewSupplier({super.key});

  @override
  State<AddNewSupplier> createState() => _AddNewSupplierState();
}

class _AddNewSupplierState extends State<AddNewSupplier> {
  bool _isLoading = false;
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController supplierNumberController = TextEditingController();
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
  TextEditingController grantedDiscountController = TextEditingController();
  Supplier supplier=Supplier(supplierAddress: []);
  final HomeController homeController = Get.find();
  StringWrapper selectedPhone=StringWrapper( "");
  StringWrapper selectedMobile=StringWrapper( "");
  StringWrapper selectedPhoneCode=StringWrapper( "");
  StringWrapper selectedMobileCode=StringWrapper( "");

  int selectedClientType = 1;
  int selectedTabIndex = 0;
  List tabsList = ['settings', 'contacts_and_addresses'];
  String recentSearchKey = '-1';
  String selectedTitle = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(text: 'create_new_supplier'.tr),
              gapH32,
              BlocBuilder<SuppliersCreationBloc, SuppliersCreationState>(
                builder: (context, state) {
                  if (state is SuppliersCreationInitial) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is SuppliersCreationLoadSuccess) {
                    return DialogTextFieldSupplier(
                      onChangedFunc: (v) {
                        state.supplierCode = v;
                      },
                      textEditingController: TextEditingController(
                        text: state.supplierCode,
                      ),
                      text: '${'supplier_code_create'.tr}*',
                      rowWidth: MediaQuery.of(context).size.width * 0.5,
                      textFieldWidth: MediaQuery.of(context).size.width * 0.4,
                      validationFunc:
                          (value) => value.isEmpty ? 'required_field'.tr : null,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              gapH16,
              Builder(
                builder: (context) {
                  double bigRowWidth =
                      homeController.isMenuOpened
                          ? MediaQuery.of(context).size.width * 0.5
                          : MediaQuery.of(context).size.width * 0.7;
                  double bigTextFieldWidth =
                      homeController.isMenuOpened
                          ? MediaQuery.of(context).size.width * 0.4
                          : MediaQuery.of(context).size.width * 0.6;
                  double smallRowWidth =
                      homeController.isMenuOpened
                          ? MediaQuery.of(context).size.width * 0.22
                          : MediaQuery.of(context).size.width * 0.27;
                  double smallTextFieldWidth =
                      homeController.isMenuOpened
                          ? MediaQuery.of(context).size.width * 0.15
                          : MediaQuery.of(context).size.width * 0.19;
                  double middleRowWidth =
                      homeController.isMenuOpened
                          ? MediaQuery.of(context).size.width * 0.25
                          : MediaQuery.of(context).size.width * 0.29;
                  double middleTextFieldWidth =
                      homeController.isMenuOpened
                          ? MediaQuery.of(context).size.width * 0.2
                          : MediaQuery.of(context).size.width * 0.25;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DialogTextFieldSupplier(
                        textEditingController: supplierNameController,
                        text: '${'supplier_name'.tr}*',
                        onChangedFunc: (v){},
                        rowWidth: bigRowWidth,
                        textFieldWidth: bigTextFieldWidth,
                        validationFunc: (value) {
                          if (value.isEmpty) return 'required_field'.tr;
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
                            rowWidth: smallRowWidth,
                            textFieldWidth: smallTextFieldWidth,
                            validationFunc: (val) {},
                          ),
                          PhoneDialogTextField(
                            read: true,
                            text: 'phone'.tr,
                            rowWidth: middleRowWidth,
                            textEditingController: phoneController,
                            textFieldWidth: middleTextFieldWidth,
                            onTap: () {
                              PhoneDialog.show(context, phoneController,selectedPhoneCode,selectedPhone);
                            },
                          ),
                          DialogTextFieldSupplier(
                            onChangedFunc: (v){},

                            textEditingController: floorBldgController,
                            text: 'floor_bldg'.tr,
                            rowWidth: smallRowWidth,
                            textFieldWidth: smallTextFieldWidth,
                            validationFunc: (val) {},
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
                                  enableSearch: true,
                                  controller: titleController,
                                  hintText: 'Doctor, Miss, Mister',
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
                                      selectedTitle = val!;
                                  },
                                ),
                              ],
                            ),
                          ),
                          PhoneDialogTextField(
                            onValidateFunc:(value) {
                            if (value.isEmpty) return 'required_field'.tr;
                            return null;
                            },
                            read: true,
                            text: '${'mobile'.tr}*',
                            rowWidth: middleRowWidth,
                            textEditingController: mobileController,
                            textFieldWidth: middleTextFieldWidth,
                            onTap: () {
                              PhoneDialog.show(context, mobileController,selectedMobileCode,selectedMobile);
                            },
                          ),
                          DialogTextFieldSupplier(
                            textEditingController: streetController,
                            text: 'street'.tr,
                            onChangedFunc: (v){},
                            rowWidth: smallRowWidth,
                            textFieldWidth: smallTextFieldWidth,
                            validationFunc: (val) {},
                          ),
                        ],
                      ),
                      gapH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DialogTextFieldSupplier(
                            textEditingController: jobPositionController,
                            text: 'job_position'.tr,
                            onChangedFunc: (v){},

                            hint: 'Sales Director,Sales...',
                            rowWidth: smallRowWidth,
                            textFieldWidth: smallTextFieldWidth,
                            validationFunc: (val) {},
                          ),
                          DialogTextFieldSupplier(
                            onChangedFunc: (v){},

                            textEditingController: emailController,
                            text: '${'email'.tr}*',
                            hint: 'example@gmail.com',
                            rowWidth: middleRowWidth,
                            textFieldWidth: middleTextFieldWidth,
                            validationFunc: (String value) {
                             if (value.isEmpty) return 'required_field'.tr;
                              if (value.isNotEmpty &&
                                  !RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                  ).hasMatch(value)) {
                                return 'check_format'.tr;
                              }
                              return null;
                            },
                          ),
                          BlocBuilder<CountryBloc, CountryState>(
                            builder: (context, state) {
                              if (state is CountryInitial) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return SizedBox(
                                  width: smallRowWidth,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('country'.tr),
                                      Container(
                                        width: smallTextFieldWidth,
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
                                        width: smallRowWidth,
                                        child: DropdownSearch<Country>(
                                          selectedItem: (context.read<CountryBloc>().state as CountryLoadSuccess).country ?? Country(),
                                          onChanged: (value)async{
                                            final countryState = context.read<CountryBloc>().state as CountryLoadSuccess;
                                            countryState.country=value!;
                                            final cBloc = context.read<CitiesBloc>();
                                            cBloc.add(LoadCities(countryId: -1,search: ''));
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
                                                selectedCountry:(cBloc.state as CountryLoadSuccess).country,
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
                      gapH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DialogTextFieldSupplier(
                            onChangedFunc: (v){},

                            textEditingController: taxNumberController,
                            text: 'tax_number'.tr,
                            rowWidth: smallRowWidth,
                            textFieldWidth: smallTextFieldWidth,
                            validationFunc: (String val) {
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
                            rowWidth: middleRowWidth,
                            textFieldWidth: middleTextFieldWidth,
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
                            width: smallRowWidth,
                            child: BlocBuilder<CitiesBloc, CitiesState>(
                              builder: (context, state) {
                                if (state is CitiesLoading) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('city'.tr),
                                      SizedBox(
                                        width: smallTextFieldWidth,
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
                                        width: smallTextFieldWidth,
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
                                          selectedItem: (context.read<CitiesBloc>().state as CitiesLoadSuccess).selectedCity??City(),
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
                                            final future = cityBloc.stream.firstWhere((state) => state is CitiesLoadSuccess);

                                            cityBloc.add(
                                              LoadCities(
                                                search: filter,
                                                page: page,
                                                countryId: (countryBloc.state as CountryLoadSuccess).country?.id ?? -1,
                                                reset: isSearch || (recentSearchKey != filter),
                                              ),
                                            );
                                            final s = await future as CitiesLoadSuccess;
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
                                    SizedBox(width: smallTextFieldWidth),
                                  ],
                                );
                              },
                            ),
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
                            children:
                                tabsList
                                    .map(
                                      (element) => _buildTabChipItem(
                                        element,
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
                                                  value: state['show_in_POS'] ?? false, // access the value from the map
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
                                                  value: state['blocked'] ?? false,
                                                  onChanged: (_) {
                                                    context.read<CheckBoxCubit>().toggle('blocked');
                                                  },
                                                ),
                                              );
                                            },
                                          )
                                        ),
                                      ],
                                    )
                                  ],
                                ): ContactsAndAddressesSection(supplierAddresses: supplier.supplierAddress!,),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: ()async {
                                    BlocProvider.of<CheckBoxCubit>(context, listen: false).resetAll();
                                    BlocProvider.of<CountryBloc>(context, listen: false).add(ResetCountry());
                                    BlocProvider.of<CitiesBloc>(context, listen: false).add(ResetCity());
                                    setState(() {
                                      selectedClientType = 1;
                                      selectedPhoneCode .value= '';
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
                                ReusableButtonWithColorSupplier(
                                  btnText: 'save'.tr,
                                    width: 100,
                                    height: 35,
                                  onTapFunction: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading=true;
                                      });
                                      String companyId=await getCompanyIdFromPref();
                                      String companyName=await getCompanyNameFromPref();
                                      String supplierNumber= ((context.read<SuppliersCreationBloc>()).state as SuppliersCreationLoadSuccess).supplierCode;
                                      String supplierNumberCopy= ((context.read<SuppliersCreationBloc>()).state as SuppliersCreationLoadSuccess).supplierCodeCopy;
                                      City? supplierCity= ((context.read<CitiesBloc>()).state as CitiesLoadSuccess).selectedCity;
                                      Country? selectedCountry= ((context.read<CountryBloc>()).state as CountryLoadSuccess).country;
                                      bool? showInPOS=context.read<CheckBoxCubit>().state["show_in_POS"];
                                      bool? isBlocked=context.read<CheckBoxCubit>().state["blocked"];
                                      supplier=Supplier(autoGeneratedNumber:supplierNumber==supplierNumberCopy?true:false,name: supplierNameController.text,company: Company(id:int.parse(companyId.toString()),name:companyName),supplierNumber:supplierNumber,type:"indivisual",city:supplierCity,street: streetController.text,floorAndBuilding: floorBldgController.text,jobPosition: jobPositionController.text,phoneCode: selectedPhoneCode.value,phoneNumber: selectedPhone.value,mobileCode: selectedMobileCode.value,mobileNumber: selectedMobile.value,reference: referenceController.text,email: emailController.text,title:titleController.text,taxId:taxNumberController.text,website: websiteController.text,paymentTerm: PaymentTerm(id:1),note: "asd",active:true,grantedDiscount:double.tryParse(grantedDiscountController.text.toString()),showOnPos: showInPOS,isBlocked: isBlocked,isCashCustomer:false,supplierAddress: supplier.supplierAddress,country: supplierCity!=null?null:selectedCountry);
                                      (context.read<SuppliersBloc>()).add(StoreSupplier(supplier: supplier));
                                      await context.read<SuppliersBloc>().stream.firstWhere((s) => s is SuppliersStatus);
                                      setState(() {
                                        _isLoading=false;
                                      });
                                       }
                                },isLoading: _isLoading,),
                                BlocListener<SuppliersBloc, SuppliersState>(
                                  listener: (context, state) {
                                    if (state is SuppliersStatus) {
                                      CommonWidgets.snackBar(state.title, state.message);
                                      if(state.statusCode!=200)return;
                                      final HomeController homeController = Get.find();
                                      homeController.selectedTab.value="purchases_and_suppliers";
                                    }
                                  },
                                  child: const SizedBox.shrink(), // invisible child
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
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
              topRight: Radius.circular(9),
            ),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.height * 0.07,
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
